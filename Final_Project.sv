module Final_Project(
			input               CLOCK_50,
			// VGA Interface 
			output logic [7:0]  VGA_R,        //VGA Red
								VGA_G,        //VGA Green
								VGA_B,        //VGA Blue
			output logic        VGA_CLK,      //VGA Clock
								VGA_SYNC_N,   //VGA Sync signal
								VGA_BLANK_N,  //VGA Blank signal
								VGA_VS,       //VGA virtical sync signal
								VGA_HS,      //VGA horizontal sync signal
								 
			input logic [3:0] Key,
			input  logic AUD_BCLK, AUD_ADCDAT, AUD_DACLRCK, AUD_ADCLRCK,
			input  logic [17:0] Switch,
			output logic AUD_MCLK, AUD_DACDAT, I2C_SDAT, I2C_SCLK,
			output logic [6:0] HEX,
			output logic [7:0]  LEDG,
			output logic [17:0]  LEDR,
			output logic [19:0] SRAM_ADDR,
			inout wire [15:0] SRAM_DQ,
			output logic SRAM_OE_N,
			output logic SRAM_CE_N, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N);

logic init, init_f, start, adc_full;
logic [15:0] board_out;
logic [31:0] board_in;
							
logic Reset_h, Clk;

assign Clk = CLOCK_50;

logic [9:0] DrawX, DrawY;
logic is_shape;

logic [1:0] vol;

logic [31:0] un_gained;
logic [15:0] gained_output;

assign {Reset_h} = ~(Key[0]);

//assign LEDG[7] = Switch[17];
assign LEDR[17] = 1'b1;
assign LEDR[14] = 1'b1;
//assign LEDR[11] = 1'b1;

assign SRAM_UB_N = 1'b0;
assign SRAM_LB_N = 1'b0;
assign SRAM_OE_N = 1'b0;
assign SRAM_CE_N = 1'b0;
assign SRAM_WE_N = 1'b1;

// Use PLL to generate the 25MHZ VGA_CLK.
// You will have to generate it on your own in simulation.
vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));

VGA_controller vga_controller_instance(.Reset(Reset_h), .*); 
 
shape shape_instance(.Reset(Reset_h), .frame_clk(VGA_VS), .next_val(board_out), .*);

color_mapper color_instance(.*);

//hexdriver hex_disp(.In(hex_vol), .Out(HEX));
hexdriver hex_disp1(.In({2'b00, vol}), .Out(HEX));
//hexdriver hex_disp2(.In(4'ha), .Out(HEX2));
gain g(.Data_in(un_gained[31:16]), .Clk(Clk), .Reset(Reset_h), .Button(~Key[1]), .Data_out(gained_output), .volume_level(vol));

Pedal_Board board_inst( .Signal_in(gained_output),
								.Clk(Clk),
								.Switches(Switch),
								.Signal_out(board_out),
								.RESET(Reset_h),
								.*);
 
audio_interface audio_interface_instance (	
		.LDATA(board_out),
		.RDATA(board_out),	
		.clk(Clk),
		.Reset(Reset_h),
		.INIT(init),
		.INIT_FINISH(init_f),
		.adc_full(adc_full),
		.data_over(),
		.AUD_MCLK(AUD_MCLK),
		.AUD_BCLK(AUD_BCLK), 
		.AUD_ADCDAT(AUD_ADCDAT), 
		.AUD_DACDAT(AUD_DACDAT), 
		.AUD_DACLRCK(AUD_DACLRCK), 
	  	.AUD_ADCLRCK(AUD_ADCLRCK),
		.I2C_SDAT(I2C_SDAT), 
		.I2C_SCLK(I2C_SCLK),
		.ADCDATA(un_gained));	
		
enum logic[1:0]{	Halt,
						Init,
						Read} State, Next_state; 
						
always_ff @(posedge Clk)
begin
if (Reset_h)
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