`include "regFile.v"

module regFile_tb();

reg [3:0] add1, add2, wadd;
reg [15:0] wr0, wdata;
reg regwrite, r0write,reset;
wire [15:0] r1data, r2data, r0data;

regFile r1(add1,add2,r1data,r2data,r0data,wadd,wr0,wdata,regwrite,r0write,reset);

initial begin
	add1 = 4'b0;
	add2 = 4'b0;
	wadd = 4'b0;
	wr0 = 16'b0;
	wdata = 16'b0;
	regwrite = 1'b0;
	r0write = 1'b0;
	reset = 1'b0;
	#10
	reset = 1'b1;
	#10
	reset = 1'b0;
	#10
	$finish;
end
endmodule
