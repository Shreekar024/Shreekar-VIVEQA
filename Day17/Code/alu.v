`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 10:49:24
// Design Name: 
// Module Name: alu
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


module alu(a,b,alu_ctrl,result,zero);
input [31:0]a,b;
input [2:0]alu_ctrl;
output zero;
output reg [31:0]result;

always @ (*)begin
   case (alu_ctrl)
   3'b000:result=a+b; //Add
   3'b001:result=a-b; //Sub
   3'b010:result=a & b; //bitwise and
   3'b011:result=a | b; //bitwise or
   default:result=32'bz;
  endcase
end

assign zero=~|result;

endmodule

