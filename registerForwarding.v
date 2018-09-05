module registerForwarding(instruction2, instructions3, instructions4, instructions5, 
							aluOut1, aluOut2, 
							dOut, aluOut1s4, aluOut2s4,
							r0Outs5, mux3Out,
							outR1, outR2, outR0, needM2, needM4, needM5,
							bubble);
	input[15:0] instruction2, instructions3, instructions4, instructions5;
	input[15:0] aluOut1,aluOut2;
	input[15:0] dOut, aluOut1s4, aluOut2s4;
	input[15:0] r0Outs5, mux3Out;
	
	output reg [15:0] outR1, outR2, outR0;
	output reg needM2, needM4, needM5, bubble;
	
	always@(*)
	begin
		if((instruction2[15:12] == "0100")|(instruction2[15:12] == "0101")|(instruction2[15:12] == "0110")|(instruction2[15:12] == "0000")|(instruction2[15:12] == "1000"))//branch
		//op1 forwarding
		begin
			if((instructions3[15:12]=="0000")&(instruction2[11:8]==instructions3[11:8]))//s3
			begin
				outR1 = aluOut1;
				needM2 = 1;
			end
			
			else if((instructions4[15:12]=="0000")&(instruction2[11:8]==instructions4[11:8]))//s4
			begin 
				outR1 = aluOut1s4;
				needM2 = 1;
			end
			else if((instructions4[15:12]=="1000")&(instruction2[11:8]==instructions4[11:8]))
			begin
				outR1 = dOut;
				needM2 = 1;
			end
			
			
			else if(((instructions5[15:12]=="0000")||(instructions5[15:12]=="1000"))&(instruction2[11:8]==instructions5[11:8]))//s5
			begin
				outR1 = mux3Out;
				needM2 = 1;
			end
				
			else if((instruction2[11:8] == "0000")&((instructions3[15:12]=="0000")&((instructions3[3:0]=="0001")|(instructions3[3:0]=="0010"))))
			begin
				needM2 = 1;
				outR1 = aluOut2;
			end
			else if((instruction2[11:8] == "0000")&((instructions4[15:12]=="0000")&((instructions4[3:0]=="0001")|(instructions4[3:0]=="0010"))))
			begin
				needM2 = 1;
				outR1 = aluOut2s4;
			end
			else if((instruction2[11:8] == "0000")&((instructions5[15:12]=="0000")&((instructions5[3:0]=="0001")|(instructions5[3:0]=="0010"))))
			begin
				needM2 = 1;
				outR1 = r0Outs5;
			end
			begin
				outR1 = 0;
				needM2 = 0;
			end
			
			
			
			
		end
		
		
		// r2
		if(((instruction2[15:12]=="0000")&(!(instruction2[3:0]=="1010"))&(!(instruction2[3:0]=="1011"))&(!(instruction2[3:0]=="1000"))&(!(instruction2[3:0]=="1001")))|(instruction2[15:12]=="1000")|(instruction2[15:12]=="1011"))
		begin
			//i know it uses op2
			//check if anyone who writes to registers if the destination is op2...aka check op1
			if((instructions3[15:12]=="0000")&(instruction2[7:4]==instructions3[11:8]))//s3
			begin
				outR2 = aluOut1;
				needM4 = 1;
			end
			else if((instructions3[15:12]=="1000")&(instruction2[7:4]==instructions3[11:8]))
			begin
				//bubble
			end
			
			
			else if((instructions4[15:12]=="0000")&(instruction2[7:4]==instructions4[11:8]))//s4
			begin 
				outR2 = aluOut1s4;
				needM4 = 1;
			end
			else if((instructions4[15:12]=="1000")&(instruction2[7:4]==instructions4[11:8]))
			begin
				outR2 = dOut;
				needM4 = 1;
			end
			
			
			else if(((instructions5[15:12]=="0000")||(instructions5[15:12]=="1000"))&(instruction2[7:4]==instructions5[11:8]))//s5
			begin
				outR2 = mux3Out;
				needM4 = 1;
			end
			
			
			
			else if((instruction2[7:4] == "0000")&((instructions3[15:12]=="0000")&((instructions3[3:0]=="0001")|(instructions3[3:0]=="0010"))))
			begin
				needM4 = 1;
				outR2 = aluOut2;
			end
			else if((instruction2[7:4] == "0000")&((instructions4[15:12]=="0000")&((instructions4[3:0]=="0001")|(instructions4[3:0]=="0010"))))
			begin
				needM4 = 1;
				outR2 = aluOut2s4;
			end
			else if((instruction2[7:4] == "0000")&((instructions5[15:12]=="0000")&((instructions5[3:0]=="0001")|(instructions5[3:0]=="0010"))))
			begin
				needM4 = 1;
				outR2 = r0Outs5;
			end
			
			
			else
			begin
				outR2 = 0;
				needM4 = 0;
			end
		end
		
		
		
		
		if((instruction2[15:12]=="0100")|(instruction2[15:12]=="0101")|(instruction2[15:12]=="0110"))
		begin
			if(instructions3[15:12]=="0000")
			begin
				if((instructions3[3:0]=="0001")|(instructions3[3:0]=="0001"))
				begin
					needM5 = 1;
					outR0 = aluOut2;					
				end
				else if(instructions3[11:8]=="0000")
				begin
					needM5 = 1;
					outR0 = aluOut1;
				end		
				else
				begin
					needM5=0;
					outR0 = 0;
				end
			end
			else if(instructions4[15:12]=="0000")
			begin
				if((instructions4[3:0]=="0001")|(instructions4[3:0]=="0001"))
				begin
					needM5 = 1;
					outR0 = aluOut2s4;					
				end
				else if(instructions4[11:8]=="0000")
				begin
					needM5 = 1;
					outR0 = aluOut1s4;
				end		
				else
				begin
					needM5=0;
					outR0 = 0;
				end
			end
			else if(instructions5[15:12]=="0000")
			begin
				if((instructions5[3:0]=="0001")|(instructions5[3:0]=="0001"))
				begin
					needM5 = 1;
					outR0 = r0Outs5;					
				end
				else if(instructions5[11:8]=="0000")
				begin
					needM5 = 1;
					outR0 = r0Outs5;
				end		
				else
				begin
					needM5 = 0;
					outR0 = 0;
				end
			end
			else if((instructions3[15:12]=="1000")&(instructions3[11:8]=="0000"))
			begin
				//wait bubble
			end
			else if((instructions4[15:12]=="1000")&(instructions4[11:8]=="0000"))
			begin
				needM5 = 1;
				outR0 = dOut;
			end
			else if((instructions5[15:12]=="1000")&(instructions5[11:8]=="0000"))
			begin
				needM5 = 1;
				outR0 = mux3Out;
			end
			else
			begin
				needM5 = 0;
				outR0 = 0;
			end
		end
		//bubble control
		if(((instruction2[15:12]=="0100")|(instruction2[15:12]=="0101")|(instruction2[15:12]=="0110"))&((instructions3[15:12]=="1000")&(instructions3[11:8]=="0000")))
		begin
			bubble =1;
		end
		else if((((instruction2[15:12]=="0000")&(!(instruction2[3:0]=="1010"))&(!(instruction2[3:0]=="1011"))&(!(instruction2[3:0]=="1000"))&(!(instruction2[3:0]=="1001")))|(instruction2[15:12]=="1000")|(instruction2[15:12]=="1011"))&((instructions3[15:12]=="1000")&(instruction2[7:4]==instructions3[11:8])))
		begin
			bubble =1;
		end
		else if(((instruction2[15:12] == "0100")|(instruction2[15:12] == "0101")|(instruction2[15:12] == "0110")|(instruction2[15:12] == "0000")|(instruction2[15:12] == "1000"))&((instructions3[15:12]=="1000")&(instruction2[11:8]==instructions3[11:8])))
		begin
			bubble =1;
		end
		else
		begin
			bubble =0;
		end
		
		
		//lastly check r0 who uses r0... everyone can except jump... do i assume that only mult and div can write to r0?
		
		
		
		
	end
endmodule
