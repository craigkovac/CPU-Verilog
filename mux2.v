module mux2(in1,in2,in3,select,out);
	input[15:0] in1,in2,in3;
	output reg [15:0] out;
	input[1:0] select;
	
	always@(*)
	begin
		case(select)
			0: out = in1;
			1: out = in2;
			2: out = in3;
			3: out = in1;
		endcase
	end
endmodule
