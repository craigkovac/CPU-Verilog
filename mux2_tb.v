`include "mux2.v"

module mux2_tb();
reg [15:0] in1,in2,in3;
reg [1:0] select;
wire [15:0] out;

mux2 m2(in1,in2,in3,select,out);

initial begin
	$monitor("Inputs = %b, %b, %b | Output = %b\n", in1, in2, in3, out);
	in1 = 16'b0;
	in2 = 16'b0;
	in3 = 16'b0;
	select = 2'b0;
	#10
	in1 = 16'b1;
	in2 = 16'b10;
	in3 = 16'b100;
	select = 2'b1;
	#10
	select = 2'b10;
	#10
	select = 2'b11;
	#10
	$finish;
end

endmodule
