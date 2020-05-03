module Pedal_Board(input logic [15:0] Signal_in,
							input logic Clk,
							input logic [17:0] Switches,
							output logic [15:0] Signal_out);
							
logic od_start, trem_start, vib_start, echo_start;


overdrive_effect OD_pedal(	.input_frame(Signal_in),
									.CLK(Clk),
									.START(od_start),
									.DONE(OD_done),
									.gain(Switches[16]),
									.output_frame(OD_out));
									


mux2_1 distmux(.d0(Signal_in),
					.d1(OD_out),
					.s(Switches[17]),
					.out(distmux_out));
//
//tremolo trem_pedal(	.in(distmux_out),
//								.Clk(Clk),
//								.START(trem_start),
//								.DONE(trem_done),
//								.speed(Switches[13]),
//								.out(trem_out));
//								
//mux2_1 tremmux(.d0(distmux_out),
//					.d1(trem_out),
//					.s(Switches[14]),
//					.out(tremmux_out));
//					
//vibrato vib_pedal(	.in(compmux_out),
//							.START(vib_start),
//							.DONE(vib_done),
//							.speed(Switches[10])
//							.out(vib_out));
//				
//mux2_1 vibmux(	.d0(tremmux_out),
//						.d1(vib_out)
//						.s(Switches[11]),
//						.out(vibmux_out));
//					
//echo echo_pedal(.in(vibmux_out),
//						.START(echo_start),
//						.DONE(echo_done),
//						.time(Switches[7]),
//						.out(echo_out));
//
//mux2_1 echomux(	.d0(vibmuxmux_out),
//						.d1(echo_out),
//						.s(Switches[8]),
//						.out(echomux_out));

always_comb
	begin				
	//Signal_out = revbmux_out;
	Signal_out = Signal_in;
	end
always_ff @(posedge Clk)
	begin
		if(OD_done & trem_done & vib_done & echo_done)
			od_start <= 0;
			trem_start <= 0;
			vib_start <= 0;
			echo_start <= 0;
		else
			od_start <= 1;
			trem_start <= 1;
			vib_start <= 1;
			echo_start <= 1;


	end
endmodule