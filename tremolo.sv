module tremolo(input  logic [15:0] Signal_in,
					input  logic CLK, RESET,
					output logic [15:0] Signal_out);

logic [10:0] volume;
logic [26:0] Signal_cut;
					
Triangle_generator twg(.CLK(CLK), .RESET(RESET), .val(volume));
always_comb
	begin
		
		Signal_cut = $signed(Signal_in) * $signed(volume);
		Signal_out = Signal_cut[26:11];
	end
endmodule
