module im(pc, out);
	input[15:0] pc;
	output reg [15:0] out;
	
	reg [27:0] instruction_memory[15:0];

initial begin
        $monitor("PC = %h, Out = %h",pc,out);
end
	always@(*)
	begin
		instruction_memory[0] = 16'b0000000100101111;
		instruction_memory[1] = 16'b0000000100101110;
		instruction_memory[2] = 16'b0000001101001100;
		instruction_memory[3] = 16'b0000001100101101;
		instruction_memory[4] = 16'b0000010101100001;
		instruction_memory[5] = 16'b0000000101010010;
		instruction_memory[6] = 16'b0000000000001110;
		instruction_memory[7] = 16'b0000010000111010;
		instruction_memory[8] = 16'b0000010000101011;
		instruction_memory[9] = 16'b0000011000111000;
		instruction_memory[10] = 16'b0000011000101001;
		instruction_memory[11] = 16'b011001110100xxxx;
		instruction_memory[12] = 16'b0000101100011111;
		instruction_memory[13] = 16'b010001110101xxxx;
		instruction_memory[14] = 16'b0000101100101111;
		instruction_memory[15] = 16'b010101110010xxxx;
		instruction_memory[16] = 16'b0000001000011111;
		instruction_memory[17] = 16'b0000001000011111;
		instruction_memory[18] = 16'b100010001001xxxx;
		instruction_memory[19] = 16'b0000100010001111;
		instruction_memory[20] = 16'b101110001001xxxx;
		instruction_memory[21] = 16'b100010101001xxxx;
		instruction_memory[22] = 16'b0000110011001111;
		instruction_memory[23] = 16'b0000110111011110;
		instruction_memory[24] = 16'b0000110011011111;
		
		out = instruction_memory[pc];
	end
endmodule
