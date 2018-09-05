`include "cpu.v"

module cpu_fixture();

reg clk, reset;

cpu uut(.clk(clk),.rst(reset));

initial begin
//	$monitor("Clock: %b | Stage1 PC=%h |\nStage2: IM = %h | Registers: 1=%h, 2=%h, R0=%h |\n Stage3 ALU_PT1=%h | Reg0=%h |\nStage4 MemADDR=%h | WriteDat=%h | ReadDat=%h |\nStage5 Out=%h | RegWrite=%h | R0Dat=%h | writeAddr=%h | R0Write=%h |", clk ,pc1,instruction,dataReg1,dataReg2,dataR0,aluOut1,aluOut2, address, dIn, dOut, outM3, regWrite, r0s5, writeAddr, r0Write);

	reset = 1'b0;
	clk = 1'b0;
	#10
	reset = 1'b1;
	#10
	reset = 1'b0;
	#10
	clk = 1'b1;
	#10
	clk = 1'b0;
	#10
	clk = 1'b1;
	#10
	clk = 1'b0;
	#10
	clk = 1'b1;
	#10
	clk = 1'b0;
	#10
	$finish;
end

always
begin
	#5 clk = !clk;
end

endmodule
