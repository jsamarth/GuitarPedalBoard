module overdrive_effect (
	input logic CLK,

	// Two cutoff levels 
	input logic gain,
	
	// 
	input logic [15:0] input_frame,	

	// This is the output frame that has been passed through the overdrive effect
	output logic [15:0] output_frame
);


logic [15:0] output_frame_next;

always_ff @ (posedge CLK) begin
	output_frame = output_frame_next;
end

always_comb begin
	output_frame_next = input_frame;
	if(gain) begin
		if($signed(output_frame_next) > $signed(16'h3a98)) begin // 15000
			output_frame_next = 16'h3a98;
		end
		if($signed(output_frame_next) < $signed(16'hc568)) begin
			output_frame_next = 16'hc568;
		end
	end
	
	else begin
		if($signed(output_frame_next) > $signed(16'h2710)) begin // 10000
			output_frame_next = 16'h2710;
		end
		if($signed(output_frame_next) < $signed(16'hd8f0)) begin
			output_frame_next = 16'hd8f0;
		end
	end
end

endmodule