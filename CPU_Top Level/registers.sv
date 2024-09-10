module registers (clk,rstn,write_a,write_b,write_o,C_in,A_reg,B_reg,OUT_reg);

	input clk, rstn;
	input write_a, write_b, write_o;
	input [7:0] C_in;
	output logic [7:0] A_reg, B_reg, OUT_reg;

	d_flipflop dff_A (
	 .clk(clk),
	 .rstn(rstn),
	 .C_in(C_in),
	 .reg_out(A_reg),
	 .write_enb(write_a)
	);

	d_flipflop dff_B (
	 .clk(clk),
	 .rstn(rstn),
	 .C_in(C_in),
	 .reg_out(B_reg),
	 .write_enb(write_b)
	);

	d_flipflop dff_OUT (
	 .clk(clk),
	 .rstn(rstn),
	 .C_in(C_in),
	 .reg_out(OUT_reg),
	 .write_enb(write_o)
	);

endmodule


