`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 11:01:14
// Design Name: 
// Module Name: top
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

//`include "ILA and VIO"

module top(clk);
input clk;
wire [31:0]a,b;
wire [2:0]alu_ctrl;
wire [31:0]result;
wire zero;

alu alu(a,b,alu_ctrl,result,zero);
ila_0 ila(
	.clk(clk), // input wire clk


	.probe0(result), // input wire [31:0]  probe0  
	.probe1(zero) // input wire [0:0]  probe1
);
vio_0 vio(
  .clk(clk),                // input wire clk
  .probe_in0(result),    // input wire [31 : 0] probe_in0
  .probe_in1(zero),    // input wire [0 : 0] probe_in1
  .probe_out0(a),  // output wire [31 : 0] probe_out0
  .probe_out1(b),  // output wire [31 : 0] probe_out1
  .probe_out2(alu_ctrl)  // output wire [2 : 0] probe_out2
);
endmodule
