module add2(pc,pc2);
	input[15:0] pc;

	output reg [15:0] pc2;
	
	always@(*) 
	begin
		pc2 = pc + 2;
	end
endmodule
