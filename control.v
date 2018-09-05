module control(instructions1, instructionOuts1, instructions2, toALU, regWrite, compare,
				mux1, mux2, mux3, mux4, mux5, wEnable, fromCompare, needM2, needM4, needM5, bubble2);

	//buffer 1
	input[15:0] instructions1, instructions2;
	output reg [15:0] instructionOuts1;
	output reg [3:0] toALU;
	output reg [1:0] regWrite, compare;
	output  reg mux3, mux4, mux5, wEnable, bubble2;
	
	//to buffer 2
	input fromCompare;
	output reg [1:0] mux1;
	
	input needM2, needM4, needM5;
	//temp just a reg
	reg bubble;
	
	output reg [1:0]  mux2;
	
	
	reg [15:0] instruction;
	
	always@(*)
	begin
	instruction <= instructions1;
		
	//knowlege from stage 1
		//opcode = 0
		//what can be decided for sure?
		//toALU--, wEnable--, regWrite--, mux3--, compartator operation--
		//find out if there is a jump here, find out if there is a halt here
		
		if((!fromCompare)&(!bubble2))//if there is not a branch bubble and load bubble
		begin
			instructionOuts1 <= instructions1;
			if(instruction[15:12]=="0000")
			begin
				compare = "11";
				wEnable = 0;
				mux3 = 0;
				
				//toALU
				if(instruction[3:0]=="1111")
				 begin
					toALU = "0000";//  +
					regWrite = "01";
				end
				else if(instruction[3:0]=="1110")
				begin
					toALU = "0001";//  -
					regWrite = "01";
				end
				else if(instruction[3:0]=="1101")
				begin
					toALU = "0010";//  &
					regWrite = "01";
				end
				else if(instruction[3:0]=="1100")
				begin
					toALU = "0011";//  |
					regWrite = "01";
				end
				else if(instruction[3:0]=="0001")
				begin
					toALU = "0100";//  *
					regWrite = "11";
					if(instruction[11:8] == "0000")
					begin
						//error
					end
				end
				else if(instruction[3:0]=="0010")
				begin
					toALU = "0101";//  /
					regWrite = "11";
					if(instruction[11:8] == "0000")
					begin
						//error
					end
				end
				else if(instruction[3:0]=="1010")
				begin
					toALU = "0110";//  lsl
					regWrite = "01";
				end
				else if(instruction[3:0]=="1011")
				begin
					toALU = "0111";//  lsr
					regWrite = "01";
				end
				else if(instruction[3:0]=="1000")
				begin
					toALU = "1000";//  rl
					regWrite = "01";
				end
				else if(instruction[3:0]=="1001")
				begin
					toALU = "1001";//  rr
					regWrite = "01";
				end
				else
				begin
					//dispay invalid function code
					toALU = "0000";
					regWrite = "00";
				end
			end
			
			//other opcodes
			else if(instruction[15:12]=="1000")// load
			begin
				regWrite = "01";
				toALU = "0000";
				wEnable = 0;
				compare = "11";
				mux3 = 1;
			end
			else if(instruction[15:12]=="1011")//store
			begin
				wEnable = 1;
				regWrite = "00";
				toALU = "0000";
				compare = "11";
				mux3 = 0;
			end
			else if(instruction[15:12]=="0100")//blt
			begin
				wEnable = 0;
				regWrite = "00";
				toALU = "0000";
				compare = "00";
				mux3 = 0;
			end
			else if(instruction[15:12]=="0101")//bgt
			begin
				wEnable = 0;
				regWrite = "00";
				toALU = "0000";
				compare = "01";
				mux3 = 0;
			end
			else if(instruction[15:12]=="0110")//be
			begin
				wEnable = 0;
				regWrite = "00";
				toALU = "0000";
				compare = "10";
				mux3 = 0;
			end
			else if(instruction[15:12]=="1100")//jump
			begin
				wEnable = 0;
				regWrite = "00";
				toALU = "0000";
				compare = "11";
				mux3 = 0;
			end
			else if(instruction[15:12]=="1111")//halt
			begin
				wEnable = 0;
				regWrite = "00";
				toALU = "0000";
				compare = "11";
				mux3 = 0;
			end
			else
			begin
				//error invalid opcode
				wEnable = 0;
				regWrite = "00";
				toALU = "0000";
				compare = "11";
				mux3 = 0;
			end
		end
		else
		begin
			//instructionOuts1 = 1'bZ; //<-- change that so there will not be any conflict with reg forwarding
			wEnable = 0;
			regWrite = "00";
			toALU = "0000";
			compare = "11";
			mux3 = 0;
		end
		
	//stage 2 knowledge
		//known items -> fromCompare, previous signals, second instruction stage
		//find out if branch jumps in this stage mux1 and says if there will be a branch bubble
		
		if(instruction[15:12]=="1111")//halt
		begin
			mux1 = "00";
			bubble = 0;
		end
		else if(instruction[15:12]=="1100")//jump
		begin
			mux1 = "10";
			bubble = 0;
		end
		else if(fromCompare)//branch
		begin
			mux1 = "11";
			bubble = 1;
			//needs to clear buffer1
		end
		else
		begin
			mux1 = "01";
			bubble = 0;
		end
		
	//stage 3 knowlege
		//overflow error <- do not write to register if overflow error?
		//need op1&2& opcode for reg forwarding
		
		
		
		//need to make mux4&5 and fix mux2
		if(needM5)
		begin
			mux5 = 1;
		end
		else
		begin
			mux5 = 0;
		end
		
		
		
		if(needM4)
		begin
			mux4 = 1;
		end
		else
		begin
			mux4 = 0;
		end
		
		
		//mux2 fix logic here
		if(needM2)
		begin
			mux2 = "01";
		end
		else if((instructions2[3:0]=="1010"||instructions2[3:0]=="1011"||instructions2[3:0]=="1000"||instructions2[3:0]=="1001")&(instructions2[15:12]=="0000"))
		begin
			mux2="10";
		end
		else if(instructions2[15:12]=="1000"||instructions2[15:12]=="1011")
		begin
			mux2 = "10";
		end
		else
		begin
			mux2 = "00";
		end
		
		
		
		
		
		
		
		
		
	//stage 4 knowledge
		//need op1&2& opcode for reg forwarding
		//load hazard?
		
	//stage 5 knowledge
		//implement reg forwarding now? need stage 5 stuff for reg forwarding?
	
	end
endmodule
		
			
			
