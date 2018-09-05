`include "branchAdd.v"

module branchAdd_tb();

reg [15:0] pc, offset;
wire [15:0] out;
branchAdd ba(.pc(pc),.offset(offset),.out(out));

initial begin
	$monitor("Out = %h\n",out);
	pc = 16'h0;
	offset = 16'h0;
	#10
	pc = 16'h2;
	offset = 16'h4;
	#10
	$finish;
end
endmodule
