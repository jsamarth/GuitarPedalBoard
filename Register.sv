module Register(input  logic Clk, Reset, Vol_up, Vol_down,
              output logic [7:0]  Data);
				  
	enum logic [3:0] {reset, Norm, up1, up2, down1, down2} State, Next_state;
	
    always_ff @ (posedge Clk)
    begin 
			State <= Next_state;
			
			// hey
    end
	
	always_comb
	begin
	Next_state = Norm;
	
	unique case (State)
		reset:
			begin
				Next_state = Norm;
				if (Reset)
					Next_state = reset;
			end
		Norm:
			begin
				Next_state = Norm;
				if (Vol_up)
					Next_state = up1;
				else if (Vol_down)
					Next_state = down1;
				else if (~Reset)
					Next_state = reset;
					
			end
			
		up1:
			begin
			Next_state = up2;
				if(Vol_up)
					Next_state = up1;
					
			end
		up2:
			begin
				Next_state = Norm;
			end		
		down1:
			begin
				Next_state = down2;
				if(Vol_down)
					Next_state = down1;
					
			end		
		down2:
			begin
				Next_state = Norm;
			end
		default:;
	endcase
	
	
	end
	
always_ff@(posedge Clk)
	begin
		case (State)
			reset:
				Data <= 8'h00;
			up2:
				Data <= {Data[2:0], 1'b1};
			down2:
				Data <= {1'b0, Data[3:1]};
			default:
				Data <= Data;
		endcase
	end	
	
	
	
endmodule
