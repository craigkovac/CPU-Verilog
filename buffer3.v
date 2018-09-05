module buffer3(aluOut1, aluOut2, op1Data, instructions3, wEnables3, mux3sels3, regWrites3, r0writes3,
				address, r0data, Din, instructions4, wEnable, mux3sels4, regWrites4, r0writes4,
				clk);
				
	input[15:0] aluOut1, aluOut2, op1Data, instructions3;
	input wEnables3, mux3sels3, regWrites3, r0writes3;
	input clk;
	
	output reg [15:0] address, r0data, Din, instructions4;
	output reg wEnable, mux3sels4, regWrites4, r0writes4;
	
	always@(posedge clk)
	begin
		address <= aluOut1;
		r0data <= aluOut2;
		Din <= op1Data;
		instructions4 <= instructions3;
		wEnable <= wEnables3;
		mux3sels4 <= mux3sels3;
		regWrites4 <= regWrites3;
		r0writes4 <= r0writes3;
	end
endmodule
