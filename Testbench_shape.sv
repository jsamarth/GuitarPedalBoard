module Testbench_shape();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic CLK;
logic [15:0] input_frame, output_frame;
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 CLK = ~CLK;
end

logic Reset, frame_clk;
logic [9:0] next_val;
logic [9:0]  DrawX, DrawY;

logic  is_shape;

shape s(.Clk(CLK), .*);

initial begin: CLOCK_INITIALIZATION
    CLK = 0;
end 

initial begin: TEST_VECTORS
	#1
	Reset = 1;

	#2
	Reset = 0;

	#2
	next_val = 8'hff;
	DrawX = 10'd400;
	DrawY = 10'd400;

	#2
	next_val = 8'hee;
	DrawX = 10'd400;
	DrawY = 10'd200;

	#2
	next_val = 8'h35;
	DrawX = 10'd300;
	DrawY = 10'd100;

	#2
	next_val = 8'haa;
	DrawX = 10'd400;
	DrawY = 10'd150;

	#2
	next_val = 8'h05;
	DrawX = 10'd0;
	DrawY = 10'd110;

end
endmodule
