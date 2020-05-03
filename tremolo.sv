module tremolo(input  logic [15:0] signal_in,
					input  logic Clk, reset,
					output logic [15:0] signal_out);
					
logic [15:0] volume; 
logic [11:0] timer; // period of the volume wave
logic u_d; // Keeps track whether volume is increasing or decreasing

always_ff @(posedge Clk)
	begin
	
		if (~reset)
			begin
			volume <= 16'h0000;
			timer <= 8'h00;
			end
			
		else
			begin
				if (timer < 4'h320)
					timer <= timer + 1;
				else
					begin
						timer <= 0;
						if (u_d)
							volume <= volume + 1;
						else
							volume <=volume - 1;	
					end
			end
		if (volume == 16'hfffe || volume == 16'h0001)
			u_d = ~u_d;
			

	end
assign signal_out = signal_in & volume;

endmodule
