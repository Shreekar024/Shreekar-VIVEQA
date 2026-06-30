`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 09:59:51
// Design Name: 
// Module Name: freq_counter
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


module freq_counter(clk,rst,led);
input clk,rst;
output reg [3:0]led;

always @ (posedge clk)begin
if (rst)
    led=4'd0;
else 
    led<=led+4'd1;
end
endmodule