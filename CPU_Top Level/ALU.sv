module ALU(A_bus,B_bus,F,C,CF,ZF);
	input [7:0] A_bus;
	input [7:0] B_bus;
	input [3:0] F;
	output logic [7:0] C;
	output logic CF;
	output logic ZF;																				


  // Internal signals
	logic [8:0] A_plus_1;
	logic [8:0] B_plus_1;
	logic [8:0] sum;
	
	// Assign operating equation for internal signal
	assign A_plus_1 = A_bus + 1'b1;
	assign B_plus_1 = B_bus + 1'b1;
	assign sum = A_bus + B_bus;

  // Logic for each ALU operation
	always_comb begin
		case (F)
		4'b0000: // C = A
			begin
				C = A_bus;
				CF = 1'b0;
				ZF = (C == 8'b0) ? 1'b1 : 1'b0;
			end
			4'b0001: // C = B
			begin
				C = B_bus;
				CF = 1'b0;
				ZF = (C == 8'b0) ? 1'b1 : 1'b0;
			end
			4'b0010: // C = A + 1
			begin
				C = A_plus_1;
				CF = A_plus_1[8]; // If the addition operation appears an overflow, the output will have 9 bits and the MSB is 1
				ZF = (C == 8'b0) ? 1'b1 : 1'b0;
			end
			4'b0011: // C = B + 1
			begin
				C = B_plus_1;
				CF = B_plus_1[8];
				ZF = (C == 8'b0) ? 1'b1 : 1'b0;
			end
			4'b0100: // C = A + B
			begin
				C = sum;
				CF = sum[8];
				ZF = (C == 8'b0) ? 1'b1 : 1'b0;
			end
			4'b0101: // C = A - B
			begin
				C = A_bus - B_bus;
				CF = (A_bus < B_bus) ? 1'b1 : 1'b0; // An overflow appears in substraction when minuend is less than the subtrahend
				ZF = (C == 8'b0) ? 1'b1 : 1'b0;
			end
			4'b0110: // C= A AND B
			begin
				C = A_bus & B_bus;
				CF = 1'b0;
				ZF = (C == 8'b0) ? 1'b1 : 1'b0;
			end
			4'b0111: // C = A OR B
			begin
				C = A_bus | B_bus;
				CF = 1'b0;
				ZF = (C == 8'b0) ? 1'b1 : 1'b0;
			end
			4'b1000: // C = A >> 1
			begin
				C = A_bus >> 1;
				CF = 1'b0;
				ZF = (C == 8'b0) ? 1'b1 : 1'b0;
			end
			4'b1001: // C = A << 1
			begin
				C = A_bus << 1;
				CF = 1'b0;
				ZF = (C == 8'b0) ? 1'b1 : 1'b0;
			end
			default: // Set all output values with 0
			begin
				C = 8'b0;
				CF = 1'b0;
				ZF = 1'b0;
			end
		endcase
	end
endmodule
