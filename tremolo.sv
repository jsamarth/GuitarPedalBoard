module tremolo(input  logic [15:0] Signal_in,
					input  logic CLK, RESET,
					output logic [15:0] Signal_out);

logic [15:0] volume;
					
Triangle_generator twg(.CLK(CLK), .RESET(RESET), .val(volume));
always_comb
	begin
		Signal_out = Signal_in & volume;
	end
endmodule
