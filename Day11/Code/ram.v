`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 11:37:36
// Design Name: 
// Module Name: ram
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

//synchronous Write and Read
//32 Width 1024 Depth
//we=1 write else read at the posedge
module ram(
    input clk,we,
    input [9:0]addr,
    input [31:0]W_data,
    output reg [31:0]R_data
    );
    
reg [31:0]mem[0:1023];

always @ (posedge clk)begin
if(we)
    mem[addr]<=W_data;
else
    R_data<=mem[addr];
end    

endmodule
