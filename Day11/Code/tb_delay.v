`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2026 11:27:06
// Design Name: 
// Module Name: tb_delay
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


module tb_delay_100;

    reg clk;
    reg a;
    wire a_delay;

    delay_100 dut (
        .clk(clk),
        .a(a),
        .a_delay(a_delay)
    );

initial begin
   clk = 0;
   forever #5 clk = ~clk;
end

initial begin
a = 0;
wait(clk==1);
a<=1;
#20 a=0;
#20 a=1;
#20 a=0;
end

endmodule