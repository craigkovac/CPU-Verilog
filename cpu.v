`include "control.v"
`include "alu.v"
`include "comparator.v"
`include "Memory.v"
`include "regFile.v"
`include "signExtend.v"
`include "signShift.v"
`include "mux1.v"
`include "mux2.v"
`include "mux3.v"
`include "mux5.v"
`include "pc.v"
`include "im.v"
`include "add2.v"
`include "jumpAdd.v"
`include "branchAdd.v"
`include "buffer4.v"
`include "buffer3.v"
`include "buffer2.v"
`include "buffer1.v"
`include "registerForwarding.v"

module cpu(clk, rst);
	initial begin
	//$monitor("%h",pc1);	
	$monitor("Clock: %b | Stage1 PC=%h |\nStage2: IM = %h | Registers:1=%h, 2=%h, R0=%h |\n Stage3 ALU_PT1=%h | Reg0=%h |\nStage4 MemADDR=%h| WriteDat=%h | ReadDat=%h |\nStage5 Out=%h | RegWrite=%h | R0Dat=%h| writeAddr=%h | R0Write=%h |", clk,pc1,instruction,dataReg1,dataReg2,dataR0,aluOut1,aluOut2, address,dIn, dOut, outM3, regWrite, r0s5, writeAddr, r0Write);
	end

	input clk, rst;
	
	wire mux4sel, mux5sel;
	wire[15:0] outR1, outR2, outR0;
	wire needM2, needM4, needM5, bubblebob;
	//stage1
	//to buffer control signals?
	// to buffer instructions1
	wire[15:0] pc1, pc2, jumpo, branch, mux1out,instruction, instructionOuts1;
	wire[1:0] mux1sel;//<---- control
	wire mux3sels1, r0Writes1, regWrites1, wEnables1;
	wire[1:0] branchOps1;
	wire[3:0] aluOps1;
	wire[1:0] controlWrite;
	
		wire[15:0] instruction2, dataReg2, dataReg1, dataR0, signData, signXOut, mux2Out, bOffset, regOut2Data, dataR0InReg;
	wire jumpie;//<--- control mux2sel
	wire[1:0] branchOp, mux2sel; //<-- control
	wire mux3sels2, r0Writes2, regWrites2, wEnables2;
	wire[3:0] aluOps2;
	wire[15:0] aluIn1, aluIn2, aluOut1, aluOut2, op1Data, instructions3;
	wire[3:0] aluOp;//<--- control
	wire overflow;//<--- error?
	wire wEnables3, mux3sels3, regWrites3, r0writes3;
		wire[15:0] address, dOut, dIn, r0datas4; //<-- control wEnable
	wire[15:0] instructions4;
	wire wEnable, mux3sels4, regWrites4, r0writes4;
		wire[15:0] in1M3, in2M3, outM3, r0s5, instructions5;
	wire[3:0] writeAddr;
	wire mux3sel;//<-- control
	wire regWrite, r0Write; //<-- control both
	
	
	
	
	
	control cont2(instruction, instructionOuts1, instruction2, aluOps1, controlWrite, branchOps1,
				mux1sel, mux2sel, mux3sels1, mux4sel, mux5sel, wEnables1, jumpie,
				needM2, needM4, needM5, bubblebob,rst);
	
	
	registerForwarding regf1(instruction2, instructions3, instructions4, instructions5, 
							aluOut1, aluOut2, 
							dOut, address, r0datas4,
							r0s5, outM3,
							outR1, outR2, outR0, needM2, needM4, needM5,
							bubblebob);
	
	
	mux5 m4(regOut2Data, outR2, dataReg2, mux4sel);
	
	mux5 m5(dataR0InReg, outR0, dataR0,  mux5sel);
	
	

	mux1 m1(pc1, pc2, branch,jumpo,mux1sel,mux1out,clk);//<-- needs output from control
	pc p1(mux1out, pc1, rst);
	im im1(pc1, instruction);//<--- needs reset
	add2 ad2(pc1, pc2);

	jumpAdd j1(pc1, instruction[11:0], jumpo);
	
	//to buffer instruction, branchOps1, mux3sels1, r0Writes1, regWrites1, wEnables1, aluOps1
	
	
	//buffer1
	buffer1 b1(instructionOuts1, branchOps1, aluOps1, mux3sels1, controlWrite[1], controlWrite[0], wEnables1,
				instruction2, branchOp, aluOps2, mux3sels2, r0Writes2, regWrites2, wEnables2, 
				clk);
	
	
	//stage2
	//needs from buffer instructions2, mux2sel, branchOp, mux3sels2, r0Writes2, regWrites2, wEnables2, aluOps2

	signExtend sign1(instruction2[7:4], signXOut);
//
	regFile reg1(instruction2[11:8], instruction2[7:4], dataReg1, regOut2Data, dataR0InReg, instructions5[11:8], r0s5, outM3, regWrite, r0Write,rst); //<-- finish at last stage & control regWrite r0Write
//
	//load data is wrong R0 has no init value
	mux2 m2(dataReg1, outR1, signXOut, mux2sel, mux2Out); // <-- needs control mux2sel
	comparator comp1(dataReg1, dataR0, branchOp, jumpie);//<-- jumpie to control & branchOp from control
	signShift shift1(instruction[7:0], bOffset);
	branchAdd branch1(pc1, bOffset, branch);

	//to buffer instruction2, mux2Out, dataReg2, dataReg1, mux3sels2, r0Writes2, regWrites2, aluOps2, wEnables2
	
	
	//buffer
	buffer2 b2(dataReg2, mux2Out, dataReg1, instruction2, aluOps2, mux3sels2, r0Writes2, regWrites2, wEnables2,
				aluIn1, aluIn2, op1Data, instructions3, aluOp, mux3sels3, r0Writes3, regWrites3, wEnables3,
				clk);
	
	//stage3
	
	
	
	
	//need aluIn1, aluIn2, instructions4, aluOp, 
	//need op1Data, mux3sels3, r0Writes3, regWrites3, wEnables3
	alu alu1(aluIn1, aluIn2, aluOp, overflow, aluOut2, aluOut1);
	//to buffer aluOut2, aluOut1, op1data, instructions3
	//control wEnables3, regWrites3, r0writes3, mux3sels3
	
	
	
	//buffer
	buffer3 b3(aluOut1, aluOut2, op1Data, instructions3, wEnables3, mux3sels3, regWrites3, r0writes3,
				address, r0datas4, dIn, instructions4, wEnable, mux3sels4, regWrites4, r0writes4,
				clk);
	
	
	
	//stage4
	//need from buffer address, dIn(op1data), instructions4, r0datas4
	//control wEnable, regWrites4, r0writes4, mux3sels4
	Memory mem1(wEnable, address, dIn, dOut, rst);
	//to buffer regWrite, mux3sel, r0Write, instruction, dOut, dIn, r0data
	
	
	
	//buffer
	buffer4 b4(regWrites4, mux3sels4, r0writes4, instructions4, dOut, address, r0datas4,
				regWrite, mux3sel, r0Write, instructions5, in1M3, in2M3, r0s5,
				clk);
	
	
	
	
	//stage5
	//need from buffer regWrite, r0Write, dOut, address, r0, Instruction
	//control regWrite, r0Write, mux3sel

	mux3 m3(in1M3, in2M3, mux3sel, outM3);
	
	
	
	
	
	
	
	
endmodule
	
