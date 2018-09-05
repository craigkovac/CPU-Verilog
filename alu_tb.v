`include "alu.v"
module alu_tb();

reg [15:0] in1,in2;
reg [3:0] select;
wire overflow;
wire [15:0] out1,out2;

alu a1(.in1(in1),.in2(in2),.select(select),.overflow(overflow),.out2(out2),.out1(out1));

initial begin
	$monitor("Output = %h and Overflow = %h\n",out1,overflow);
	in1 = 16'h0;
	in2 = 16'h0;
	select = 4'h0;
	#10
	in1 = 16'h4;
	in2 = 16'h4;
	select = 4'h1;
	#10
	select = 4'h2;
	#10
	select = 4'h3;
	#10
	select = 4'h4;
	#10
	$finish;
	
end
endmodule
