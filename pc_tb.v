`include "pc.v"

module pc_tb();

reg [15:0] pc;
wire [15:0] out;
reg rst;

pc p1(pc,out,rst);

initial begin
	$monitor("PC = %h\n",out);
	rst = 0;
	#10
	rst = 1;
	#10
	rst = 0;
	#100
	$finish;
end
endmodule
