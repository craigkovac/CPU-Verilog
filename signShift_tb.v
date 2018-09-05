`include "signShift.v"

module signShift_tb();

reg [7:0] in2;
wire [15:0] out2;

signShift s1(in2,out2);

initial begin
	$display("Out = %b\n", out2);
	in2 = 8'h0;
	#10
	in2 = 8'b00001111;
	#10

        $display("Out = %b\n", out2);

	$finish;
end

endmodule

