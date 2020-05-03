module overdrive_effect (
	input logic CLK,
	input logic START,
	output logic DONE,

	// How much gain to apply to the sound. '0' means 2 times. '1' means 3 times 
	input logic gain,
	
	// This is the input frame of a 1000 samples, with every sample having a 16 bit width.
	input signed logic[15:0] input_frame,	

	// This is the output frame that has been passed through the overdrive effect
	output signed logic[15:0] output_frame,
);

logic[15:0] output_sound;
always_ff @ (posedge CLK) begin
	if(START == 0) begin
		output_sound <= 16'h0000;
		DONE <= 0;
	end

	else begin
		output_sound <= input_frame * (gain + 2);
		DONE <= 1'b1;
	end
end

endmodule
