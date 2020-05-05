module gain(input logic Clk, Reset, Button,
			input logic [15:0] Data_in,
			output logic [15:0] Data_out,
			output logic[1:0] volume_level);
				  
enum logic [2:0] {reset, Stb0, Lvl1, Stb1, Lvl2, Stb2, Lvl3, Stb3} State, Next_state;

logic [15:0] Data_out_next;
logic[1:0] volume_level_next;

always_ff @ (posedge Clk) begin 
	if (Reset) begin
		State <= reset;
		volume_level <= 2'b00;
		Data_out <= Data_in;
	end
	else begin
		State <= Next_state;
		volume_level <= volume_level_next;
		Data_out <= Data_out_next;
	end
end

// Handle state machine
always_comb begin
	Next_state = reset;
	
	unique case (State)
		reset: begin
			Next_state = reset;
			if (Button != 0)
				Next_state = Stb0;
		end
		Stb0: begin
			Next_state = Stb0;
			if (Button == 0)
				Next_state = Lvl1;		
		end
		Lvl1: begin
			Next_state = Lvl1;
			if (Button != 0)
				Next_state = Stb1;		
		end
		Stb1: begin
			Next_state = Stb1;
			if (Button == 0)
				Next_state = Lvl2;		
		end
		Lvl2: begin
			Next_state = Lvl2;
			if (Button != 0)
				Next_state = Stb2;		
		end
		Stb2: begin
			Next_state = Stb2;
			if (Button == 0)
				Next_state = Lvl3;		
		end
		Lvl3: begin
			Next_state = Lvl3;
			if (Button != 0)
				Next_state = Stb3;		
		end
		Stb3: begin
			Next_state = Stb3;
			if (Button == 0)
				Next_state = reset;		
		end
		default:;
	endcase	
end
	
// Handle what happens in different states
always_comb begin
	Data_out_next = Data_out;
	volume_level_next = volume_level;
	unique case (State)
		reset: begin
			Data_out_next = Data_in;
			volume_level_next = 0;
		end
		Stb0: begin

		end
		Lvl1: begin
			Data_out_next = Data_in;
			if(Data_in < 16'h3fff)
				Data_out_next = Data_in << 1;
			volume_level_next = 2'b01;
		end
		Stb1: begin
				
		end
		Lvl2: begin
			Data_out_next = Data_in;
			if(Data_in < 16'h1fff)
				Data_out_next = Data_in << 2;
			volume_level_next = 2'b10;
		end
		Stb2: begin
				
		end
		Lvl3: begin
			Data_out_next = Data_in;
			if(Data_in < 16'h0fff)
				Data_out_next = Data_in << 3;
			volume_level_next = 2'b11;
		end
		Stb3: begin
				
		end
		default:;
	endcase	
end

endmodule
