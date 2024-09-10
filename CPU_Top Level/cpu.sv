module cpu(clk, rstn, ex_btn, op_code, ext_data, OUT_reg, CF, ZF); // Should be cpu.sv

	// Input
	input logic clk, rstn;
	input logic ex_btn;
	input logic [3:0] op_code;
	input logic [7:0] ext_data;
	
	// Output
	output logic [7:0] OUT_reg;
	output logic CF, ZF;
	
	// Internal logic registers and wires (for interconnection)
	logic [7:0] A_reg, B_reg; // A register and B register output
	logic [7:0] C_bus; // Output of ALU
	logic [7:0] B_bus; // Output of MUX41 from b_reg and ext_data
	logic write_a, write_b, write_o; // Enable for 3 DFFs
	logic [1:0] B_sel; // For MUX41
	logic [3:0] F_sel; // For ALU
	
	// Instantiate this module with the other 4 minor modules
	
	// ALU instantiation (with file name ALU.sv)
	ALU alu_instance (
		.C(C_bus), // The name of variable of C bus is C_bus
		.CF(CF),
		.ZF(ZF),
		.A_bus(A_reg), // The A register of this module is connected with A bus in ALU.sv
		.B_bus(B_bus), // The output of mux41 b_bus
		.F(F_sel)
	);
	
	// Registers instantiation (with file name registers.sv)
	registers reg_instance (
		.clk(clk),
		.rstn(rstn),
		.write_a(write_a),
		.write_b(write_b),
		.write_o(write_o),
		.C_in(C_bus),
		.A_reg(A_reg),
		.B_reg(B_reg),
		.OUT_reg(OUT_reg)
	);
	
	// MUX41 instantiation (with file name mux41.sv)
	mux41 mux41_instance (
		.b_reg(B_reg),
		.b_sel(B_sel),
		.b_bus(B_bus),
		.ext_data(ext_data) // Ext_data should be declared input and assign value
	);
	
	// Control Unit instantiation (with file name control_unit.sv)
	control_unit control_unit_instance (
		.clk(clk),
		.rstn(rstn),
		.ex_btn(ex_btn),
		.opcode(op_code),
		.write_a(write_a),
		.write_b(write_b),
		.write_o(write_o),
		.F_sel(F_sel),
		.B_sel(B_sel)
	);
	
	// Code function for ex_btn
	
	// Assign output
//	assign OUT_reg = C_bus;

endmodule
