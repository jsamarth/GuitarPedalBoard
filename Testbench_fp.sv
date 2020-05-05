module Testbench_fp();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic CLK;
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 CLK = ~CLK;
end

logic Reset, Vol_up, Vol_down;
logic [7:0]  Data;
logic [3:0] hex_vol;

Register rs(.*, .Clk(CLK));


initial begin: CLOCK_INITIALIZATION
    CLK = 0;
end 

initial begin: TEST_VECTORS

	#1
	Reset = 1;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 1;
	Vol_down = 0;
	
	#3
	Reset = 0;
	Vol_up = 0;
	Vol_down = 1;
	
	#3
	Reset = 0;
	Vol_up = 0;
	Vol_down = 1;
	
	#3
	Reset = 0;
	Vol_up = 0;
	Vol_down = 1;
		
	
end
endmodule
