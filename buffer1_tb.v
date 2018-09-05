`include "buffer1.v"

module buffer1_tb();

        reg [15:0] instruction;
        reg [1:0] branchOps1;
        reg [3:0] aluOps1;
        reg mux3sels1, r0Writes1, regWrites1, wEnables1;
        reg clk;

        wire [15:0] instructions2;
        wire [1:0] branchOp;
        wire [3:0] aluOps2;
        wire mux3sels2, r0Writes2, regWrites2, wEnables2;

buffer1 b1(instruction, branchOps1, aluOps1, mux3sels1, r0Writes1, regWrites1, wEnables1,
                                instructions2, branchOp, aluOps2, mux3sels2, r0Writes2, regWrites2, wEnables2,
                                clk);

initial begin 
	$monitor("Clk = %b", clk);
	clk = 0;
	instruction = 16'h0;
	branchOps1 = 2'h0;
	#100
	$finish;
end

always begin
	#5 clk = !clk; 
end
endmodule
