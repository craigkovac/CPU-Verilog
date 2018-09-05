module pc(in, out, reset);
	input[15:0] in;
	input reset;
	output reg [15:0] out;
	
	
	
	always@(*)
	begin
		if(reset)
		begin
			out = 16'b0;
		end
		else
		begin
			out=in;
		end
	end
endmodule
