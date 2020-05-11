//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  shape ( input       Clk,                // 50 MHz clock
							Reset,              // Active-high reset signal
							frame_clk,          // The clock indicating a new frame (~60Hz)
				input [15:0] next_val,
	   			input [9:0] DrawX, DrawY,       // Current pixel coordinates
				output logic is_shape             // Whether current pixel belongs to ball or background
			  );

	logic [9:0] counter;

	logic [15:0]mem_block [640];
	logic [7:0]val_to_pop;

	assign val_to_pop = mem_block[0];
	
	//////// Do not modify the always_ff blocks. ////////
	// Detect rising edge of frame_clk
	logic frame_clk_delayed, frame_clk_rising_edge;
	always_ff @ (posedge Clk) begin
		frame_clk_delayed <= frame_clk;
		frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
	end

	always_ff @ (posedge Clk) begin
		if(Reset) begin
			counter <= 1;
			for(int i = 0; i < 640; i++)
				mem_block[i] <= 0;
		end

		else begin
			if(counter == 100) begin
				for(int i = 0; i < 639; i++)
					mem_block[i] <= mem_block[i+1];
				mem_block[639] <= next_val;
				counter <= 0;
			end
			counter <= counter + 1;
		end
	end

	// Update registers
	// always_ff @ (posedge Clk)
	// begin
		
	// end

	// always_comb begin
		
	// end
	
	// Compute whether the pixel corresponds to shape or background
	/* Since the multiplicants are required to be signed, we have to first cast them
	   from logic to int (signed by default) before they are multiplied. */

	logic[7:0] to_check;
	assign to_check = mem_block[DrawX] >>> 8;
	always_comb begin
		if (DrawX >= 0 && DrawX <= 640 && (DrawY == $signed(to_check)+$signed(240)))
			is_shape = 1'b1;
		else
			is_shape = 1'b0;
	end
	
endmodule
