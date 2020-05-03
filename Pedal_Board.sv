module Pedal_Board(input logic [15:0] Signal_in,
							input logic Clk,
							input logic [17:0] Switches,
							output logic [15:0] Signal_out);
							
logic od_start

//clean clean_pedal(.in(Signal_in),
//						.out(clean_out));
//
overdrive_effect OD_pedal(	.input_frame(Signal_in),
									.CLK(Clk),
									.START(od_start),
									.Done(OD_done),
									.gain(Switches[0]),
									.output_frame(dist_out));
									
// Hellooooooo

//mux4_1 distmux(.d0(Signal_in),
//					.d1(clean_out)
//					.d2(dist_out),
//					.d3(Signal_in),
//					.s(Switches[17:16]),
//					.out(distmux_out));
//
//compressor comp_pedal(	.in(distmux_out),
//								.out(comp_out));
//								
//mux2_1 compmux(.d0(distmux_out),
//					.d1(comp_out),
//					.s(Switches[15]),
//					.out(compmux_out));
//					
//looper loop_pedal(.in(compmux_out),
//						.out(looper_out));
//				
//mux2_1 loopmux(.d0(compmux_out),
//					.d1(looper_out)
//					.s(Switches[14]),
//					.out(loopmux_out));
//					
//reverb reverb_pedal(	.in(loopmux_out),
//							.out(revb_out));
//
//mux2_1 revbmux(.d0(loopmux_out),
//					.d1(revb_out),
//					.s(Switches[13]),
//					.out(revbmux_out));

always_comb
	begin				
	//Signal_out = revbmux_out;
	Signal_out = Signal_in;
	end
always_ff @(posedge Clk)
	begin
		if(OD_done)
			od_start <= 0;
		else
			od_start <= 1;


	end
endmodule