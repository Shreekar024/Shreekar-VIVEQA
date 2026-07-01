`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 09:44:08
// Design Name: 
// Module Name: clk_gen
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
`include "Xilinx Clock Wizard IP core"

module clk_gen(
    input clk_in1,reset,
    output clk_out1,clk_out2,clk_out3,clk_out4,locked
    );
      clk_wiz_0 clk_gen
   (
    .clk_out1(clk_out1),     
    .clk_out2(clk_out2),     
    .clk_out3(clk_out3),    
    .clk_out4(clk_out4),     
    .reset(reset),
    .locked(locked),
    
    .clk_in1(clk_in1)     
);
endmodule
