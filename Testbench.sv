module Testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic CLK;
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 CLK = ~CLK;
end

logic [15:0] Signal_in;
logic [17:0] Switches;
logic [15:0] Signal_out;
logic RESET;
logic [19:0] SRAM_ADDR;
logic [15:0] SRAM_DQ;

Pedal_Board PB(.Clk(CLK), .*);

initial begin: CLOCK_INITIALIZATION
    CLK = 0;
end 

initial begin: TEST_VECTORS

	#1
	Signal_in = 16'h4af3;
	Switches = 18'h00000;
	RESET = 1'b1;
	
	#1
	RESET = 1'b0;
	
	#5
	Signal_in = 16'h4af3;
	Switches = 18'h2f000;
	
	#5
	Switches = 18'h20000;
	
	#5
	Signal_in = 16'h0005;
	
	#5
	Signal_in = 16'hfa8d;
	
	#5
	Switches = 18'h0f000;
		
	
end
endmodule