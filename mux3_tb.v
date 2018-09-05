`include "mux3.v"

module mux3_tb();
reg [15:0] in1, in2;
reg select;
wire [15:0] out;

mux3 m3(in1,in2,select,out);

initial begin
	$monitor("Inputs = %b, %b | Output = %b\n",in1,in2,out);
	in1 = 16'h0;
	in2 = 16'h0;
	select = 1'b0;
	#10
	in1 = 16'h10;
	in2 = 16'hff;
	select = 1'b0;
	#10
	select = 1'b1;
	#10
	$finish;
end
endmodule
