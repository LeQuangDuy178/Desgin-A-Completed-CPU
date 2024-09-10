module control_unit(clk, rstn, ex_btn, opcode, write_o, write_a, write_b, B_sel, F_sel);

	// Declare input, output
		
	input logic [3:0] opcode;
	input clk, rstn;
	input ex_btn;
	
	output logic [1:0] B_sel; // output of b_selection for mux41 (note that the external button value will be declared on mux41 module)
	output logic write_a, write_b, write_o; // output to a, b, out register for enable
	output logic [3:0] F_sel; // output of F_selection for ALU
	
	//Internal signals
	logic [3:0] decoded_opcode;
	logic [3:0] state;
	
	//Combinational logic for opcode decoding
	always_comb begin
		case (opcode)
			4'b0000: decoded_opcode = 4'b0000;
			4'b0001: decoded_opcode = 4'b0001;
			4'b0010: decoded_opcode = 4'b0010;
			4'b0011: decoded_opcode = 4'b0011;
			4'b0100: decoded_opcode = 4'b0100;
			4'b0101: decoded_opcode = 4'b0101;
			4'b0110: decoded_opcode = 4'b0110;
			4'b0111: decoded_opcode = 4'b0111;
			4'b1000: decoded_opcode = 4'b1000;
			4'b1001: decoded_opcode = 4'b1001;
			4'b1010: decoded_opcode = 4'b1010;
			4'b1011: decoded_opcode = 4'b1011;
			default: decoded_opcode = 4'bxxxx;
		endcase
	end
	
	// Sequential with clk and rstn
	always_ff@(posedge clk) 
	begin
		if(!rstn) // If reset button is triggered (active-low)
			state <= 4'b1100; // This is the state when rstn is trigger
		else // Else if (rstn)
			if (!ex_btn)
			begin
				case (decoded_opcode)
					4'b0000: state <= 4'b0000;
					4'b0001: state <= 4'b0001;
					4'b0010: state <= 4'b0010;
					4'b0011: state <= 4'b0011;
					4'b0100: state <= 4'b0100;
					4'b0101: state <= 4'b0101;
					4'b0110: state <= 4'b0110;
					4'b0111: state <= 4'b0111;
					4'b1000: state <= 4'b1000;
					4'b1001: state <= 4'b1001;
					4'b1010: state <= 4'b1010;
					4'b1011: state <= 4'b1011;
				endcase
			end
	end
	
	// Logic of opcode execution through given states
	always_comb
	begin
		case (state)
			4'b0000: begin
				// NOP: Do nothing, no operation
				// Not doing is in IDLE mode
				B_sel = 2'b01;
				F_sel = 4'bxxxx;
				write_a = 1'b0;
				write_b = 1'b0;
				write_o = 1'b0;
			end
			4'b0001: begin
				// INPUT
				B_sel = 2'b11;
				F_sel = 4'b0001; // Load register from B_bus to C_bus out through ALU
				write_o = 1'b0;
				write_a = 1'b1;
				write_b = 1'b0;
			end
			4'b0010: begin
				// OUPUT
				B_sel = 2'b01;
				F_sel = 4'b0000;
				write_o = 1'b1; // Output from register A -> through ALU to input of out_register
				write_a = 1'b0;
				write_b = 1'b0;
			end
			4'b0011: begin
				// MOV A,B
				B_sel = 2'b01;
				F_sel = 4'b0000;
				write_o = 1'b0;
				write_a = 1'b0;
				write_b = 1'b1; // move value from a_reg to b_reg
			end
			4'b0100: begin
				// SHL
				B_sel = 2'b01;
				F_sel = 4'b1001;
				write_o = 1'b0;
				write_a = 1'b1;
				write_b = 1'b0;
			end
			4'b0101: begin
				// SHR
				B_sel = 2'b01;
				F_sel = 4'b1000;
				write_o = 1'b0;
				write_a = 1'b1;
				write_b = 1'b0;
			end
			4'b0110: begin
				// INCA
				B_sel = 2'b01;
				F_sel = 4'b0010;
				write_o = 1'b0;
				write_a = 1'b1;
				write_b = 1'b0;
			end
			4'b0111: begin
				// INCB
				B_sel = 2'b00;
				F_sel = 4'b0011;
				write_o = 1'b0;
				write_a = 1'b0;
				write_b = 1'b1;
			end
			4'b1000: begin
				// ADD A,B
				B_sel = 2'b00;
				F_sel = 4'b0100;
				write_o = 1'b0;
				write_a = 1'b1;
				write_b = 1'b0;
			end
			4'b1001: begin
				// SUB A,B
				B_sel = 2'b00;
				F_sel = 4'b0101;
				write_o = 1'b0;
				write_a = 1'b1;
				write_b = 1'b0;
			end
			4'b1010: begin
				// AND A,B
				B_sel = 2'b00;
				F_sel = 4'b0110;
				write_o = 1'b0;
				write_a = 1'b1;
				write_b = 1'b0;
			end
			4'b1011: begin
				// OR A,B
				B_sel = 2'b00;
				F_sel = 4'b0111;
				write_o = 1'b0;
				write_a = 1'b1;
				write_b = 1'b0;
			end
			4'b1100: begin // This is for !rstn case
				B_sel = 2'b01;
				F_sel = 4'bxxxx;
				write_a = 1'b0;
				write_b = 1'b0;
				write_o = 1'b0;
			end
			default: begin
				B_sel = 2'b01;
				F_sel = 4'bxxxx;
				write_a = 1'b0;
				write_b = 1'b0;
				write_o = 1'b0;
			end
		endcase
	end
	
endmodule



