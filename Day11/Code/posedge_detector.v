`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2026 11:22:48
// Design Name: 
// Module Name: posedge_detecter
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


module posedge_detector (
    input  wire clk,
    input  wire a,
    output wire pulse);

reg a_d;

always @(posedge clk)
begin
a_d <= a;   
end

assign pulse = a & ~a_d;

endmodule
