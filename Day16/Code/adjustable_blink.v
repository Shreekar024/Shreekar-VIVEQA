`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 16:01:55
// Design Name: 
// Module Name: adjustable_blink
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


module adjustable_blink(
    input clk,          // 50 MHz clock
    input btn_inc,      // BTN1
    input btn_dec,      // BTN2
    output reg led
);

reg [2:0] speed_sel = 2;    // Start at 2 Hz
reg [31:0] divider;
reg [31:0] count = 0;

// Speed selection
always @(posedge btn_inc or posedge btn_dec)
begin
    if(btn_inc && speed_sel < 4)
        speed_sel <= speed_sel + 1;
    else if(btn_dec && speed_sel > 0)
        speed_sel <= speed_sel - 1;
end

// Lookup table
always @(*)
begin
    case(speed_sel)
        3'd0: divider = 24000000; // 0.5 Hz
        3'd1: divider = 12000000; // 1 Hz
        3'd2: divider = 6000000;  // 2 Hz
        3'd3: divider = 3000000;  // 4 Hz
        3'd4: divider = 1500000;  // 8 Hz
        default: divider = 6000000;
    endcase
end

// LED blinking
always @(posedge clk)
begin
    if(count >= divider-1)
    begin
        count <= 0;
        led <= ~led;
    end
    else
        count <= count + 1;
end

endmodule