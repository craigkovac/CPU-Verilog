module Memory(writeEnable, address, dataIn, dataOut, reset);
	input[15:0] address;
	input writeEnable, reset;
	input[15:0] dataIn;
	output reg [15:0] dataOut;
	integer j;
	
	
	reg [65535:0] mem [15:0];//dunno
	
	always @(*)
	begin
		if(reset)
		begin
			mem[1] <= 43929;
			for(j=0;j<65536;j = j + 1)
			begin
				mem[j] <= 0;
			end
		end
		if(writeEnable)
		begin
			mem[address] <= dataIn;
			dataOut <= dataIn;
		end
		else
		begin
			dataOut <= mem[address];
		end
	end
endmodule
