`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 10:12:56
// Design Name: 
// Module Name: mealy_1001
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


module mealy_1001(
input clk,rst,ip,
output op
    );
wire [1:0]q,qb;
wire d0,d1;

assign d0=ip|(q[1] & qb[0]);
assign d1=(q[0] & qb[1] & ~ip)|(qb[0] & q[1] & ~ip);
assign op=q[0] & q[1] & ip;

//clk,rst,d,q,qb
dff dff0(clk,rst,d0,q[0],qb[0]);
dff dff1(clk,rst,d1,q[1],qb[1]);

endmodule