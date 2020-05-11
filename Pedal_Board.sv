module Pedal_Board(input logic [15:0] Signal_in,
						input logic RESET,
							input logic Clk,
							input logic [17:0] Switches,
							output logic [15:0] Signal_out,
							
							output logic [19:0] SRAM_ADDR,
							inout wire [15:0] SRAM_DQ);
							
logic od_start, trem_start, vib_start, delay_start;
logic OD_done, trem_done, vib_done, delay_done;
logic [15:0] OD_wire, trem_wire, delay_wire;
logic [15:0] OD_out, trem_out, delay_out;

overdrive_effect OD_pedal(	.input_frame(Signal_in),
									.CLK(Clk),
									.gain(Switches[16]),
									.output_frame(OD_out));
									
									
always_comb
	begin
		
		if (Switches[17])
			OD_wire = OD_out;
		else
			OD_wire = Signal_in;
		
	end									
									
									
tremolo trem_pedal(	.Signal_in(OD_wire),
							.CLK(Clk),
							.RESET(RESET),
							//.speed(Switches[13]),
							.Signal_out(trem_out));
							
always_comb
	begin
		if(Switches[14])
			trem_wire = trem_out;
		else
			trem_wire = OD_wire;
	end
				
		
									
//delay d(							.input_frame(trem_wire),
//									.CLK(Clk),
//									//.delay_time(Switches[10]),
//									.output_frame(delay_out), .*);
//									

//always_comb
//	begin
//		if(Switches[11])
//			delay_wire = delay_out;
//		else
//			delay_wire = trem_wire;
//	end

					
			

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
//	Signal_out = echomux_out;
//	Signal_out = delay_wire;
	Signal_out = trem_wire;
	//Signal_out = Signal_in;
	end


endmodule