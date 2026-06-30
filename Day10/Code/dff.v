module dff (
    input  wire clk,
    input  wire rst,
    input  wire d,
    output reg  q,
    output reg  qb
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end
    assign qb=~q;
endmodule
