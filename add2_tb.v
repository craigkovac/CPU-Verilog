`include "add2.v"
module add2_tb();

reg [15:0] pc;
wire [15:0] out;
add2 a2(pc,out);

initial begin
	$monitor("total is %h",out);
	pc = 16'h2;	#10
        $monitor("total is %h",out);

	pc = 16'h4; #10
        $monitor("total is %h",out);

	#20
	$finish;
end


endmodule
