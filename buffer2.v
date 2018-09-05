module buffer2(r2DataIn, mux2dataIn, r1DataIn, instruction2, aluOps2, mux3sels2, r0Writes2, regWrites2, wEnables2,
				aluIn1, aluIn2, op1Datas3, instructions3, aluOp, mux3sels3, r0Writes3, regWrites3, wEnables3,
				clk);
	input[15:0] r2DataIn, mux2dataIn, r1DataIn, instruction2;
	input[3:0] aluOps2;
	input mux3sels2, r0Writes2, regWrites2, wEnables2,clk;
	
	output reg [15:0] aluIn1, aluIn2, op1Datas3, instructions3;
	output reg [3:0] aluOp;
	output reg mux3sels3, r0Writes3, regWrites3, wEnables3;
	
	always@(posedge clk)
	begin
		aluIn1 <= r2DataIn;
		aluIn2 <= mux2dataIn;
		op1Datas3 <= r1DataIn;
		instructions3 <= instruction2;
		aluOp <= aluOps2;
		mux3sels3 <= mux3sels2;
		r0Writes3 <= r0Writes2;
		regWrites3 <= regWrites2;
		wEnables3 <= wEnables2;
		
		
		
	end
endmodule







