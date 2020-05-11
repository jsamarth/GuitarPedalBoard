module Testbench_gain();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic CLK;
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 CLK = ~CLK;
end

logic Reset, Button;
logic [15:0] Data_in;
logic [15:0] Data_out;
logic[1:0] volume_level;

gain g(.*, .Clk(CLK));


initial begin: CLOCK_INITIALIZATION
    CLK = 0;
end 

initial begin: TEST_VECTORS

	#1
	Reset = 1;
	
	#1
	Reset = 0;
	
	#5
	Data_in = 16'h4537;
	Button = 1;
	
	#10
	Button = 0;
	
	#20
	Button = 1;
	
	#20
	Button = 0;

	#20
	Button = 1;
	
	#2
	Button = 0;
	
	#5
	Button = 1;
	
	#10
	Button = 0;
		
	#20
	Button = 1;
	
	#20
	Button = 0;
	
	#2
	Button = 1;
	
	#2
	Button = 0;
	
	#5
	Data_in = 16'h4537;
	
	#5
	Data_in = 16'hffff;
	
	#5
	Data_in = 16'h0100;
	
	#5
	Data_in = 16'hf000;
	
end
endmodule
