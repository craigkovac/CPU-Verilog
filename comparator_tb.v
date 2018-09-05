`include "comparator.v"

module comparator_tb();

reg [15:0] r0,r1;
reg [1:0] operation;
wire jump;

initial begin
	$monitor("R0 = %h, R1 = %h, Operation = %b, jump = %b\n",r0,r1,operation,jump);
	r0 = 16'h0;
	r1 = 16'h0;
	operation = 2'h0;
	#10
	r0 = 16'hFFFF;
	r1 = 16'hAAAA;
	operation = 2'h1;
	#10
	operation = 2'h2;
	#10
	$finish;
end
endmodule
