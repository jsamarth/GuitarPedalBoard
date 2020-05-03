module Testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic CLK;
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 CLK = ~CLK;
end

logic START;
logic DONE;
logic gain;
logic signed [15:0] input_frame;
logic signed [15:0] output_frame;

overdrive_effect od_effect(.*);

initial begin: CLOCK_INITIALIZATION
    CLK = 0;
end 

initial begin: TEST_VECTORS

	#1
	gain = 1'b0;
	START = 1'b1;
	input_frame = 16'h3333;
	
	#2
	START = 0;
	
end
endmodule
