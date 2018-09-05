module buffer4(regWriteIn, mux3selIn, r0WriteIn, instructionIn, dOutIn, dInIn, r0dataIn, 
				regWriteOut, mux3selOut, r0WriteOut, instructionOut, dOutOut, dInOut, r0dataOut,
				clk);
	input[15:0] instructionIn, dOutIn, dInIn, r0dataIn;
	input mux3selIn, r0WriteIn, regWriteIn, clk;
	output reg [15:0] instructionOut, dOutOut, dInOut, r0dataOut;
	output reg mux3selOut, r0WriteOut, regWriteOut;
	
	always@(posedge clk)
	begin
		instructionOut = instructionIn;
		dOutOut = dOutIn;
		dInOut =  dInIn; 
		r0dataOut = r0dataIn;
		mux3selOut = mux3selIn;
		r0WriteOut = r0WriteIn;
		regWriteOut = regWriteIn;
		 
	end
endmodule
