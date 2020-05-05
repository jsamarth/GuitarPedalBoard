module delay #(parameter delay_time = 20000) (
	input logic CLK,

	// Two cutoff levels 
	//input logic delay_time,
	input logic RESET,
	// 
	input logic [15:0] input_frame,	

	// This is the output frame that has been passed through the overdrive effect
	output logic [15:0] output_frame,
	
	output logic [19:0] SRAM_ADDR,
	inout wire [15:0] SRAM_DQ
);

logic [19:0] address, next_address, delayed_address;

logic [15:0] output_frame_next;

always_ff @ (posedge CLK) begin
	if(RESET) begin
		output_frame <= input_frame;
		address <= 0;
	end
	else begin 
		output_frame <= output_frame_next;
		address <= next_address;
		
	end
end

always_comb begin
	next_address = address+1;
	if(next_address == delay_time)
		next_address = 0;
		
	SRAM_ADDR = next_address;
	SRAM_DQ = input_frame;
	
	delayed_address = next_address-1;
	if(next_address == 0)
		delayed_address = delay_time-1;
		
	SRAM_ADDR = delayed_address;
	output_frame_next = input_frame >>> 2 + SRAM_DQ;
end

endmodule
