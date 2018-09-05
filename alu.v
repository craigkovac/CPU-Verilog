module alu(in1, in2, select, overflow, out2, out1);
	input signed [15:0] in1, in2;
	input [3:0] select;
	output reg overflow;
	output reg signed[15:0] out1, out2;

	always @(*)
	begin
		//no need for zero bit
		case(select)
			0: begin
				{overflow,out1} = in1+in2;//can i do that
			end
			1: begin
				{overflow,out1} = in1+in2;
			end
			2: begin
				out1 = in1&in2;
			end
			3: begin
				out1 = in1|in2;
			end
			4: begin
				{out2,out1} = in1*in2;
			end
			5: begin
				out1 = in1/in2;
				out2 = in1%in2;
			end
			6: begin
				out1 = in1<<in2;
			end
			7: begin
				out1 = in1>>in2;
			end
			8: begin
				out1 = {(in1<<in2)|(in1>>(16-in2))};
			end
			9: begin
				out1 = {(in1<<(16-in2))|(in2>>in2)};
			end
		endcase
	end
endmodule
