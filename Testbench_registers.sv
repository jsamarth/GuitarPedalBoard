module Testbench_regs();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic CLK;
logic [15:0] Signal_in, Signal_out;
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 CLK = ~CLK;
end

logic RESET;

tremolo trem(.*);


initial begin: CLOCK_INITIALIZATION
    CLK = 0;
end 

initial begin: TEST_VECTORS

	#1
	RESET = 1;
	Signal_in = 16'h3fb1;
	
	#3
	RESET = 0;

		
	
end
endmodule
