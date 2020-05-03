module Final_Project(input  logic Clk, Reset,
							input  logic AUD_BCLK, AUD_ADCDAT, AUD_DACLRCK, AUD_ADCLRCK,
							input  logic [17:0] Switch,
							output logic AUD_MCLK, AUD_DACDAT, I2C_SDAT, I2C_SCLK);
							
logic init, init_f, start, adc_full;
logic [15:0] board_out;
logic [31:0] board_in;

Pedal_Board board_inst( .Signal_in(board_in[15:0]),
								.Clk(Clk),
								.Switches(Switch),
								.Signal_out(board_out));
 
audio_interface audio_interface_instance (	
		.LDATA(board_out),
		.RDATA(board_out),	
		.clk(Clk),
		.Reset(Reset),
		.INIT(init),
		.INIT_FINISH(init_f),
		.adc_full(adc_full),// clock for sram
		.data_over(),
		.AUD_MCLK(AUD_MCLK), //???
		.AUD_BCLK(AUD_BCLK), 
		.AUD_ADCDAT(AUD_ADCDAT), 
		.AUD_DACDAT(AUD_DACDAT), 
		.AUD_DACLRCK(AUD_DACLRCK), 
      .AUD_ADCLRCK(AUD_ADCLRCK), //
		.I2C_SDAT(I2C_SDAT), 
		.I2C_SCLK(I2C_SCLK),
		.ADCDATA(board_in) );	
		
enum logic[1:0]{	Halt,
						Init,
						Read} State, Next_state; 
						
always_ff @(posedge Clk)
begin
if (~Reset)
	State <= Halt;
	
else
	State <= Next_state;
	
end

always_comb
begin
	
	unique case (State)
			Halt:
				Next_state = Init;
			Init:
				begin
					if (init_f)
						Next_state = Read;
					else
						Next_state = Init;
				end
			Read:
				Next_state = Read;
		endcase	
	case (State)
		Halt:
			init = 1'b0;
		Init:
			init = 1'b1;
		Read:
			init = 1'b1;
	endcase
end

endmodule
