`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 10:18:34
// Design Name: 
// Module Name: mul_18
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


module mul_18(
    input             clk,
    input             rst,
    input             en,
    input      [17:0] A,
    input      [17:0] B,
    output reg [47:0] Y
);

wire [35:0] mult;

assign mult = A * B;

always @(posedge clk or posedge rst) begin
    if (rst)
        Y <= 48'd0;
    else if (en)
        Y <= Y + {12'd0, mult};   
end

endmodule
