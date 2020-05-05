module Triangle_generator (
	input logic CLK,
	input logic RESET,
	output logic [10:0] val
);


logic [15:0] timer; // period of the volume wave
logic u_d; // Keeps track whether volume is increasing or decreasing

always_ff @(posedge CLK)
	begin
	
		if (RESET)
			begin
			val <= 11'h005;
			timer <= 16'h00000;
			u_d = 1;
			end
			
		else
			begin
				if (timer < 16'h3200)
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
		if (val == 11'd1000)
			u_d = 0;
		else if (val == 11'h000)
			u_d = 1;

	end

endmodule

