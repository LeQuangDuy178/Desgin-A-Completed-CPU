module d_flipflop(C_in, clk, rstn, write_enb, reg_out);

	input clk, rstn;
	input write_enb;
	input [7:0] C_in;
	output logic [7:0] reg_out;
	
	always_ff@(posedge clk)
	begin
		if (!rstn) // Active-low reset trigger to reset register to zero
			reg_out <= 1'b0;
		else
			if (write_enb) // If enable is the dff block is trigger from control unit
				reg_out <= C_in; // Pass the value from in to out
	end

endmodule
				