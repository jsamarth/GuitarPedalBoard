module overdrive_effect (
	input logic CLK,
	input logic START,
	output logic DONE,

	// How much gain to apply to the sound. '0' means 2 times. '1' means 3 times 
	input logic signed gain,
	
	// This is the input frame of a 1000 samples, with every sample having a 16 bit width.
	input logic signed [15:0] input_frame,	

	// This is the output frame that has been passed through the overdrive effect
	output logic signed [15:0] output_frame
);

logic signed [17:0] temp_output;
logic signed [15:0] output_frame_next;

always_ff @ (posedge CLK) begin
	if(START == 0) begin
		DONE <= 0;
	end

	else begin
		output_frame = output_frame_next;
		DONE <= 1'b1;
	end
	
	if(DONE == 1)
		DONE <= 0;
end

logic signed [3:0]temp_sum; 
assign temp_sum = gain + 3'sb010;
assign temp_output = input_frame * temp_sum;

always_comb begin
	output_frame_next = temp_output;
	if(temp_output > 16'sh7fff)
		output_frame_next = 16'sh7fff;
	else if(temp_output < 16'sh8000)
		output_frame_next = 16'sh8000;
end

endmodule
