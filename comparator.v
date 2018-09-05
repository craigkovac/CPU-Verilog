module comparator(r0, r1, operation, jump);
	input[15:0] r0, r1;
	input[1:0] operation;
	output reg jump;

	always@(*)
	begin
		if(operation=="00")
		begin
			if(r0<r1)
				jump = 1;
			else
				jump = 0;

		end
		else if(operation =="01")
		begin
			if(r0>r1)
				jump = 1;
			else
				jump = 0;
		end
		else if(operation =="10")
		begin
			if(r0==r1)
				jump =1;
			else
				jump =0;

		end
		else
		begin
			jump = 0;
		end
	end
endmodule
