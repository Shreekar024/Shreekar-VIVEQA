`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 10:13:35
// Design Name: 
// Module Name: i2c_master
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module i2c_master #(
    parameter PRESCALER = 60
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       en,
    input  wire       rw,
    input  wire [6:0] slave_addr,
    input  wire [7:0] reg_addr,
    input  wire [7:0] data_wr,
    output reg  [7:0] data_rd,
    output reg        busy,
    output reg        ack_err,
    output wire       scl,
    // SDA split into three signals - connect to IOBUF in top module
    output reg        sda_out,   // what master wants to put on SDA
    output reg        sda_oe,    // 1 = master drives, 0 = Hi-Z (slave drives)
    input  wire       sda_in     // what is actually on the SDA wire (IOBUF.O)
);

    localparam CNT_W = 8;
    reg [CNT_W-1:0] pcnt;
    reg [1:0]       phase;
    reg             scl_en;

    wire tick = (pcnt == PRESCALER - 1);
    assign scl = scl_en ? phase[1] : 1'b1;

    always @(posedge clk) begin
        if (rst) begin
            pcnt  <= 0;
            phase <= 0;
        end else if (tick) begin
            pcnt  <= 0;
            phase <= phase + 1;
        end else begin
            pcnt  <= pcnt + 1;
        end
    end

    wire sda_drive = tick & (phase == 2'd0);  // end of phase 0 → update SDA
    wire scl_rise  = tick & (phase == 2'd1);  // end of phase 1 → SCL goes high
    wire sda_samp  = tick & (phase == 2'd2);  // end of phase 2 → sample SDA
    wire bit_end   = tick & (phase == 2'd3);  // end of phase 3 → bit period done

    // ----------------------------------------------------------
    // FSM states
    // ----------------------------------------------------------
    localparam [3:0]
        IDLE        = 4'd0,
        START       = 4'd1,
        WR_ADDR     = 4'd2,
        WR_ADDR_ACK = 4'd3,
        WR_REG      = 4'd4,
        WR_REG_ACK  = 4'd5,
        WR_DATA     = 4'd6,
        WR_DATA_ACK = 4'd7,
        REP_START   = 4'd8,
        RD_ADDR     = 4'd9,
        RD_ADDR_ACK = 4'd10,
        RD_DATA     = 4'd11,
        RD_NACK     = 4'd12,
        STOP        = 4'd13;

    reg [3:0] state;
    reg [7:0] shift_reg;
    reg [2:0] bit_cnt;
    reg       rw_save;
    reg       ack_lat;

    always @(posedge clk) begin
        if (rst) begin
            state     <= IDLE;   scl_en    <= 0;
            sda_out   <= 1;      sda_oe    <= 1;
            busy      <= 0;      ack_err   <= 0;
            data_rd   <= 0;      shift_reg <= 0;
            bit_cnt   <= 7;      rw_save   <= 0;
            ack_lat   <= 1;
        end else begin
            ack_err <= 0;

            case (state)

                IDLE: begin
                    scl_en  <= 0;
                    sda_out <= 1;  sda_oe <= 1;
                    busy    <= 0;
                    if (en) begin
                        rw_save   <= rw;
                        shift_reg <= {slave_addr, 1'b0};
                        bit_cnt   <= 7;
                        busy      <= 1;
                        state     <= START;
                    end
                end

                // SDA falls while SCL=1  →  START condition
                START: begin
                    scl_en <= 0;
                    sda_oe <= 1;
                    if (scl_rise) sda_out <= 0;
                    if (bit_end) begin
                        scl_en  <= 1;
                        sda_out <= shift_reg[7];
                        state   <= WR_ADDR;
                    end
                end

                // Transmit 8 bits MSB-first
                WR_ADDR, WR_REG, WR_DATA, RD_ADDR: begin
                    sda_oe <= 1;
                    if (sda_drive) begin
                        sda_out   <= shift_reg[7];
                        shift_reg <= {shift_reg[6:0], 1'b0};
                    end
                    if (bit_end) begin
                        if (bit_cnt == 0) begin
                            bit_cnt <= 7;
                            case (state)
                                WR_ADDR: state <= WR_ADDR_ACK;
                                WR_REG:  state <= WR_REG_ACK;
                                WR_DATA: state <= WR_DATA_ACK;
                                default: state <= RD_ADDR_ACK;
                            endcase
                        end else
                            bit_cnt <= bit_cnt - 1;
                    end
                end

                // Release SDA, slave pulls low for ACK
                WR_ADDR_ACK, WR_REG_ACK, WR_DATA_ACK, RD_ADDR_ACK: begin
                    if (sda_drive) begin
                        sda_oe  <= 0;        // release - slave drives
                        sda_out <= 1;
                    end
                    if (sda_samp) ack_lat <= sda_in;  // latch ACK while SCL=1
                    if (bit_end) begin
                        if (ack_lat !== 1'b0) begin
                            ack_err <= 1;
                            state   <= STOP;
                        end else begin
                            case (state)
                                WR_ADDR_ACK: begin
                                    shift_reg <= reg_addr;
                                    state     <= WR_REG;
                                end
                                WR_REG_ACK: begin
                                    if (rw_save == 0) begin
                                        shift_reg <= data_wr;
                                        state     <= WR_DATA;
                                    end else
                                        state <= REP_START;
                                end
                                WR_DATA_ACK: state <= STOP;
                                default: begin       // RD_ADDR_ACK
                                    shift_reg <= 0;
                                    state     <= RD_DATA;
                                end
                            endcase
                        end
                    end
                end

                // SDA rises then falls while SCL=1  →  Repeated START
                REP_START: begin
                    scl_en <= 0;
                    sda_oe <= 1;
                    if (sda_drive) sda_out <= 1;
                    if (scl_rise)  sda_out <= 0;
                    if (bit_end) begin
                        scl_en    <= 1;
                        shift_reg <= {slave_addr, 1'b1};
                        bit_cnt   <= 7;
                        sda_out   <= slave_addr[6];
                        state     <= RD_ADDR;
                    end
                end

                // Slave drives SDA; master samples via sda_in
                RD_DATA: begin
                    sda_oe <= 0;                       // release - slave drives
                    if (sda_samp) begin
                        shift_reg <= {shift_reg[6:0], sda_in};
                        if (bit_cnt == 0)
                            data_rd <= {shift_reg[6:0], sda_in};
                    end
                    if (bit_end) begin
                        if (bit_cnt == 0) begin
                            bit_cnt <= 7;
                            state   <= RD_NACK;
                        end else
                            bit_cnt <= bit_cnt - 1;
                    end
                end

                // Master sends NACK (SDA=1) - end of read
                RD_NACK: begin
                    sda_oe  <= 1;
                    sda_out <= 1;
                    if (bit_end) state <= STOP;
                end

                // SDA rises while SCL=1  →  STOP condition
                STOP: begin
                    scl_en <= 0;
                    sda_oe <= 1;
                    if (sda_drive) sda_out <= 0;
                    if (scl_rise)  sda_out <= 1;
                    if (bit_end) begin
                        busy  <= 0;
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule



