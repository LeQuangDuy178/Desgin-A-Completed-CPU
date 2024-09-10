`timescale 1ns/1ps

module mux41_tb();

	// In Out
	logic [7:0] b_reg;
	logic [1:0] b_sel;
	logic [7:0] b_bus;
	
	parameter gnd = 2'b00;
	
	// External Data
	logic [7:0] ext_data;
	
	// Module instantiating
	mux41 mux41_testing_0 (
		.b_reg(b_reg),
		.b_sel(b_sel),
		.b_bus(b_bus),
		.ext_data(ext_data)
	);
	
	// Signal generation
	
	// b_sel
	initial
	begin
		b_sel = 2'b00;
		#10 b_sel = 2'b01;
		#20 b_sel = 2'b10;
		#40 b_sel = 2'b11;
		#70 b_sel = 2'b00;
	end
	
	// b_reg
	initial
	begin	
		b_reg = 8'b0;
		#5 b_reg = 8'b00100110;
		#45 b_reg = 8'b01011110;
		#80 b_reg = 8'b10000110;
	end
	
	// ext_data
	initial
	begin
		ext_data = 8'b0;
		#5 ext_data = 8'b10010110;
	end
	
	// Display value
	initial
	begin
		$monitor("b_reg = %b, b_sel = %b, b_bus = %b, ext_data = %b", b_reg, b_sel, b_bus, ext_data);
	end
	
endmodule
