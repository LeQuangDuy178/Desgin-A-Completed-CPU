// Registers for DFF_A/B/OUT testbench

`timescale 1ns/1ps

module registers_tb();

	// In Out
	logic [7:0] C_in;
	logic clk, rstn;
	logic write_a, write_b, write_o;
	logic [7:0] A_reg, B_reg, OUT_reg;
	
	// Instantiate module
	registers reg_testing_0 (
		.clk(clk),
		.rstn(rstn),
		.C_in(C_in),
		.write_a(write_a),
		.write_b(write_b),
		.write_o(write_o),
		.A_reg(A_reg),
		.B_reg(B_reg),
		.OUT_reg(OUT_reg)
	);
	
	// Signal Generation
	
	// CLK
	initial
	begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end
	
	// RSTN
	initial
	begin
		rstn = 1'b1;
		#20 rstn = 1'b0;
		#70 rstn = 1'b1;
	end
	
	// C_in input
	initial
	begin
		C_in = 8'b0;
		#10 C_in = 8'b10010110;
		#90 C_in = 8'b0;
	end
	
	// Write_a/b/o
	initial
	begin
		write_a = 1'b0;
		write_b = 1'b0;
		write_o = 1'b0;
		#10 write_a = 1'b1;
		#20 write_b = 1'b1;
		#30 write_o = 1'b1;
	end
	
	// Display output
	initial
	begin
		$monitor("in_C = %b for 3 inputs, clk = %b, rstn = %b, a_enb = %b, b_enb = %b, out_enb = %b, therefore a_reg = %b, b_reg = %b, out_reg = %b", C_in, clk, rstn, write_a, write_b, write_o, A_reg, B_reg, OUT_reg);
	end
	
endmodule

