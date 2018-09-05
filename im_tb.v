`include "im.v"

module im_tb();

reg [15:0] pc;
wire [15:0] out;

im im1(pc,out);

initial begin
	pc = 16'h0;
	#10
	pc = 16'h1;
	#10
	pc = 16'h10;
	#10
	$finish;
end
endmodule
