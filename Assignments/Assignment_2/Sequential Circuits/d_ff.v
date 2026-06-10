module d_ff(clk,rst,D,Q);
input clk,rst,D;
output reg Q;

always @(posedge clk or posedge rst)
begin
if(rst)
Q<=0;
else
Q<=D;
end

endmodule