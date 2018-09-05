module mux1(in1,in2,in3,in4,select,out, clk);
	input[15:0] in1,in2,in3,in4;
	output reg [15:0] out;
	input[1:0] select;
	input clk;
	
	always@(posedge clk)
	begin
		case(select)
			0: out <= in1;
			1: out <= in2;
			2: out <= in3;
			3: out <= in4;
			default: out = 16'b0;
		endcase
	end
endmodule
