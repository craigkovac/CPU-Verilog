module jumpAdd(pc, offset, out);
	input[15:0] pc;
	input[11:0] offset;
	output reg [15:0] out;
	//overflow needs taken into account
	
	always@(*)
	begin
		out = pc + offset;
	end
endmodule
