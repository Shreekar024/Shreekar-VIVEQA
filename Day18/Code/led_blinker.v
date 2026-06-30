`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 12:34:38
// Design Name: 
// Module Name: led_blinker
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


module led_blinker(clk,led);
input clk;
output reg [3:0]led=0;

assign clk_out=clk;

reg [23:0]counter=0;
localparam  clk1=24'd1_499_999;

always @(posedge clk)begin
   if(counter==clk1)begin
      counter = 24'd0;
	  led[0]=~led[0];
   end else
      counter=counter +1;
end
always @(posedge led[0])
	  led[1]=~led[1];

always @(posedge led[1])
	  led[2]=~led[2];
	  
always @(posedge led[2])
	  led[3]=~led[3];

endmodule