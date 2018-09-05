`include "Memory.v"

module Memory_tb();

reg [15:0] address, dataIn;
reg writeEnable, reset;
wire [15:0] dataOut;

initial begin
	$monitor("Address = %h, Data = %h, Enable = %b, Output = %h\n", address, dataIn, writeEnable, dataOut);
	address = 16'b0;
	dataIn = 16'b0;
	writeEnable = 1'b0;
	reset = 1'b0;
	#10
	reset = 1'b1;
	#10
	reset = 1'b0;
	#10
	address = 16'hFF;
	dataIn = 16'hAA;
	writeEnable = 1'b1;
	#10
	writeEnable = 1'b0;
	#10
	$finish;
end
endmodule
