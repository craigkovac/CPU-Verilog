module buffer1(instruction, branchOps1, aluOps1, mux3sels1, r0Writes1, regWrites1, wEnables1,
				instructions2, branchOp, aluOps2, mux3sels2, r0Writes2, regWrites2, wEnables2, 
				clk);
	input[15:0] instruction;
	input[1:0] branchOps1;
	input[3:0] aluOps1;
	input mux3sels1, r0Writes1, regWrites1, wEnables1;
	input clk;
	
	output reg [15:0] instructions2;
	output reg [1:0] branchOp;
	output reg [3:0] aluOps2;
	output reg mux3sels2, r0Writes2, regWrites2, wEnables2;
	
	always@(posedge clk)
	begin
		instructions2 <= instruction;
		branchOp <= branchOps1;
		aluOps2 <= aluOps1;
		mux3sels2 <= mux3sels1;
		r0Writes2 <= r0Writes1;
		regWrites2 <= regWrites1;
		wEnables2 <= wEnables1;
		
		
	end
endmodule
