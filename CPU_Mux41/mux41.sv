module mux41(b_reg, b_bus, b_sel, ext_data);

	input [7:0] b_reg;
	input logic [1:0] b_sel;
	output logic [7:0] b_bus;
	
	// Assume the value of ext_data is 8'b10010110 (will be declared in simulation)
	input [7:0] ext_data; // Should be input logic

	parameter gnd = 2'b00;
	
	always_comb begin
	case (b_sel)
		2'b00: b_bus = b_reg;
		2'b01: b_bus = gnd;
		2'b10: b_bus = gnd;
		2'b11: b_bus = ext_data;
		default: b_bus = 8'b0;
	endcase
	end

endmodule
