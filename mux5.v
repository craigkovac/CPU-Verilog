module mux5(in1,in2,out, select);
	input[15:0] in1, in2;
	input select;
	output reg [15:0] out;
	always@(*)
	begin
		case(select)
			0: out = in1;
			1: out = in2;
		endcase
	end
endmodule
