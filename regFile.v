module regFile(input [3:0] add1, add2,  
				output reg [15:0] r1data, r2data, r0data, 
				input[3:0] wadd,
				input[15:0] wr0, wdata, 
				input regwrite, r0write,reset);

reg [15:0] registers[15:0];
reg selected_register[15:0];


initial begin
	$monitor("R0 = %h, R1 = %h, R2 = %h, R3 = %h, R4 = %h",registers[0],registers[1],registers[2],registers[3],registers[4]);
end
always @(*)
begin
	if(reset)
	begin
		registers[0] <= 16'h0F00;
		registers[1] <= 16'h0050;
		registers[2] <= 16'hFF0F;
		registers[3] <= 16'hF0FF;
		registers[4] <= 16'h0040;
		registers[5] <= 16'h0024;
		registers[6] <= 16'h00FF;
		registers[7] <= 16'hAAAA;
		registers[8] <= 16'h0000;
		registers[9] <= 16'h0000;
		registers[10] <= 16'h0000;
		registers[11] <= 16'hFFFF;
		registers[12] <= 16'h0002;
		registers[13] <= 16'h0000;
		registers[14] <= 16'h0000;
		registers[15] <= 16'h0000;
	end
	if(r0write)
	begin
		registers[0] <= wr0;
	end

	r0data <= registers[0];

	if(regwrite)
	begin
		registers[wadd] <= wdata;
	end
	
	r1data <= registers[add1];
	r2data <= registers[add2];
end
endmodule
