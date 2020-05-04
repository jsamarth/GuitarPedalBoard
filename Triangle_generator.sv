module triangle_wave_generator (
	input logic CLK,
	input logic RESET,
	output logic [15:0] val
);


logic [11:0] timer; // period of the volume wave
logic u_d; // Keeps track whether volume is increasing or decreasing

always_ff @(posedge CLK)
	begin
	
		if (~RESET)
			begin
			val <= 16'h0000;
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
							val <= val + 1;
						else
							val <=val - 1;	
					end
			end
		if (val == 16'hfffe || val == 16'h0000)
			u_d = ~u_d;
			

	end

endmodule

