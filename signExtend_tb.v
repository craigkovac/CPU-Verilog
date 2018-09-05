`include "signExtend.v"

module signExtend_tb();

reg [3:0] in4;
wire [15:0] out16;

signExtend s1(in4,out16);

initial begin
	$monitor("Out = %b", out16);
	in4 = 4'b0;
	#10
	in4 = 4'b1111;
	#10
	$finish;
end

endmodule
