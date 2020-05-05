module overdrive_effect (
	input logic CLK,
	input logic START,
	output logic DONE,

	// Two cutoff levels 
	input logic gain,
	
	// 
	input logic [15:0] input_frame,	

	// This is the output frame that has been passed through the overdrive effect
	output logic [15:0] output_frame
);


logic [15:0] output_frame_next;

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

always_comb begin
	output_frame_next = input_frame;
	if(gain) begin
		if($signed(output_frame_next) > $signed(16'h3fff)) begin
			output_frame_next = 16'h3fff;
		end
		if($signed(output_frame_next) < $signed(16'hbfff)) begin
			output_frame_next = 16'hbfff;
		end
	end
	
	else begin
		if($signed(output_frame_next) > $signed(16'h0fff)) begin
			output_frame_next = 16'h0fff;
		end
		if($signed(output_frame_next) < $signed(16'h8fff)) begin
			output_frame_next = 16'h8fff;
		end
	end
end

endmodule
