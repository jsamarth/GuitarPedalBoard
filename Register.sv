module Register(input  logic Clk, Reset, Vol_up, Vol_down,
              output logic [7:0]  Data,
				  output logic [3:0] hex_vol);
				  
	enum logic [3:0] {reset, Norm, up1, up2, down1, down2} State, Next_state;
	
    always_ff @ (posedge Clk)
    begin 
			State <= Next_state;
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
	
always_comb
	begin
		case (Data)
		8'h00:
			hex_vol =4'h0;
		8'h01:
			hex_vol =4'h1;		
		8'h03:
			hex_vol =4'h2;
		8'h07:
			hex_vol =4'h3;		
		8'h0f:
			hex_vol =4'h4;		
		8'h1f:
			hex_vol =4'h5;		
		8'h3f:
			hex_vol =4'h6;		
		8'h7f:
			hex_vol =4'h7;		
		8'hff:
			hex_vol =4'h8;		
		default:
			hex_vol = 4'hf;
		endcase
	end
	
	
	
endmodule
