module tremolo(input  logic [15:0] signal_in,
					input  logic Clk, reset,
					output logic [15:0] signal_out);
					
Triangle_generator twg(.CLK(Clk), .RESET(reset), .val(volume);
assign signal_out = signal_in & volume;

endmodule
