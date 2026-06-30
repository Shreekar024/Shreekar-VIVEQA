`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2026 09:55:07
// Design Name: 
// Module Name: sdp
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


//sdp RAM 
//Asynchronous Read
//32 Width 1024 Depth
//we =1 write the data at the posedge of clock
//we =0 read the at the posedge of clock
module sdp(
input clk,we,
input [9:0]w_addr,r_addr,
input [31:0]write_data,
output [31:0]read_data);

reg [31:0]mem[0:1023];

always@(posedge clk)begin
   if(we)
    mem[w_addr] <=write_data;
end

assign read_data=mem[r_addr];

endmodule

