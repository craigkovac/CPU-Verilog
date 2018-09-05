module signExtend(in4, out16);
	input[3:0] in4;
	output reg [15:0] out16;
	
	always@(*)
	begin
		out16 = {8'b000000000000 , in4};
	end
endmodule
