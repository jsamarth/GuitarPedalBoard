module Testbench_od();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic CLK;
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 CLK = ~CLK;
end

// Two cutoff levels 
logic gain;
logic [15:0] input_frame;

// This is the output frame that has been passed through the overdrive effect
logic [15:0] output_frame;

overdrive_effect od(.*);

initial begin: CLOCK_INITIALIZATION
    CLK = 0;
end 

initial begin: TEST_VECTORS
	#1
	gain = 0;
	input_frame = 16'h0005;
	
	#5
	gain = 1;
	
	#5
	gain = 0;
	input_frame = 16'h8885;
	
	#5
	gain = 1;
	
	#5
	gain = 0;
	input_frame = 16'h7335;
	
	#5
	gain = 1;
	
	#5
	gain = 0;
	input_frame = 16'hfff5;
	
	#5
	gain = 1;
	
	#5
	gain = 0;
	input_frame = 16'h0005;
	
	#5
	gain = 1;
		
	
end
endmodule