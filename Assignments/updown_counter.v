module updown_counter (
    input  wire       clk,
    input  wire       rst,
    input  wire       ctrl,
    input  wire       load,
    input  wire [3:0] din,
    output wire [3:0] q
);

wire clk1, clk2, clk3;
wire d0, d1, d2, d3;

assign clk1 = ctrl ? ~q[0] : q[0];
assign clk2 = ctrl ? ~q[1] : q[1];
assign clk3 = ctrl ? ~q[2] : q[2];

assign d0 = load ? din[0] : ~q[0];
assign d1 = load ? din[1] : ~q[1];
assign d2 = load ? din[2] : ~q[2];
assign d3 = load ? din[3] : ~q[3];

dff ff0 (clk,  rst, d0, q[0]);
dff ff1 (clk1, rst, d1, q[1]);
dff ff2 (clk2, rst, d2, q[2]);
dff ff3 (clk3, rst, d3, q[3]);

endmodule