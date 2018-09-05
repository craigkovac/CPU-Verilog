module signShift(in2, out2);
	input[7:0] in2;
	output reg [15:0] out2;
	
	always@(*)
	begin
		out2 = {"00000000" , in2} << 1;
	end
endmodule
