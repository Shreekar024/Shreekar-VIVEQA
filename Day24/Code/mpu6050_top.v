`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 10:14:28
// Design Name: 
// Module Name: mpu6050_top
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


module mpu6050_top (
    input  wire clk,  
    input  wire rst,  
    output wire scl,   
    inout  wire sda    
);

    localparam PRESCALER = 60;  

    wire sda_out;
    wire sda_oe;
    wire sda_in;

    IOBUF u_sda_iobuf (
        .I  (sda_out),   // fabric → pad
        .O  (sda_in),    // pad → fabric  (always valid read-back)
        .IO (sda),       // physical pin
        .T  (~sda_oe)    // active-low: 0=drive, 1=Hi-Z
    );


    wire [7:0] vio_reg_addr;
    wire [7:0] vio_data_wr;
    wire       vio_rw;
    wire       vio_en;

    wire [7:0] data_rd;
    wire       busy;
    wire       ack_err;

    reg vio_en_prev;
    wire en_pulse = vio_en & ~vio_en_prev;

    always @(posedge clk) begin
        if (rst) vio_en_prev <= 0;
        else     vio_en_prev <= vio_en;
    end

    i2c_master #(
        .PRESCALER (PRESCALER)
    ) u_i2c (
        .clk        (clk),
        .rst        (rst),
        .en         (en_pulse),
        .rw         (vio_rw),
        .slave_addr (7'h68),       // MPU-6050 address (AD0=GND)
        .reg_addr   (vio_reg_addr),
        .data_wr    (vio_data_wr),
        .data_rd    (data_rd),
        .busy       (busy),
        .ack_err    (ack_err),
        .scl        (scl),
        .sda_out    (sda_out),     // → IOBUF.I
        .sda_oe     (sda_oe),      // → IOBUF.T (inverted)
        .sda_in     (sda_in)       // ← IOBUF.O
    );


    vio_0 u_vio (
        .clk        (clk),
        .probe_in0  (data_rd),       // [7:0]  received byte
        .probe_in1  (busy),          // [0]
        .probe_in2  (ack_err),       // [0]
        .probe_out0 (vio_reg_addr),  // [7:0]  register to access
        .probe_out1 (vio_data_wr),   // [7:0]  byte to write
        .probe_out2 (vio_rw),        // [0]    0=write 1=read
        .probe_out3 (vio_en)         // [0]    toggle to trigger
    );

    ila_0 u_ila (
        .clk     (clk),
        .probe0  (data_rd),       // [7:0]  byte received from sensor
        .probe1  (scl),           // [0]    I2C clock
        .probe2  (sda_in),        // [0]    SDA wire state (fabric net)
        .probe3  (busy),          // [0]    transaction in progress
        .probe4  (ack_err),       // [0]    NACK received
        .probe5  (u_i2c.state)    // [3:0]  FSM state for debugging
    );

endmodule
