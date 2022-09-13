module contador_debouncer (

	input clk, reset, button,
	output[7:0] counter,
	input sel,
	output [6:0] segmentosd, segmentosu
);

wire clk_div;
wire debounce;

clock_divider DIVISOR (
	.clock_in(clk),
	.clock_out(clk_div)
);
	
one_shot DEBOUNCER (

	.clk(clk_div),
	.button(button),
	.button_state(debounce)

);
	
counter CONTADOR (

	.clk(debounce),
	.reset(reset),
	.sel(sel),
	.counter(counter),
	.segmentosd(segmentosd),
	.segmentosu(segmentosu)

);
	 
endmodule
