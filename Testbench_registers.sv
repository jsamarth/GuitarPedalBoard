module Testbench_regs();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic CLK;
logic [15:0] input_frame, output_frame;
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 CLK = ~CLK;
end

logic gain;

overdrive_effect OD(.*);


initial begin: CLOCK_INITIALIZATION
    CLK = 0;
end 

initial begin: TEST_VECTORS

	#1
	gain = 1;
	input_frame = 16'h13a8;
	
	#3
	gain = 0;
	
	#3
	gain = 1;
	input_frame = 16'h7918;
	


		
	
end
endmodule
