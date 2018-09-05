module mux3(in1, in2, select, out);
	input[15:0] in1, in2;
	input select;
	output reg [15:0] out;
	
	always@(*)
	begin
		if(select)
		begin
			out = in2;
		end
		else
		begin
			out = in1;
		end
	end
endmodule
