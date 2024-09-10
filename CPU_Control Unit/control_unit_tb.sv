`timescale 1ns/1ps 
// Fix the signal delay of opcode so that it dont collide with clk edge

module control_unit_tb();
	
	// Declare input, output, parameter
	
	// Parameter
	parameter half_period = 10;
	
	// Input
	logic [3:0] opcode;
	logic clk, rstn;
	logic ex_btn; // Might be used after clarifying
	
	// Output
	logic write_a, write_b, write_o;
	logic [3:0] F_sel;
	logic [1:0] B_sel;
	
	// Data in text automation
	logic [3:0] opcode_data[0:255];
	logic write_a_data[0:255], write_b_data[0:255], write_o_data[0:255];
	logic [3:0] F_sel_data[0:255];
	logic [1:0] B_sel_data[0:255];
	
	// Instantiate module for control unit testing
	control_unit CU_testing_0 (
		.opcode(opcode), 
		.clk(clk), 
		.rstn(rstn), 
		.ex_btn(ex_btn), 
		.write_a(write_a),
		.write_b(write_b),
		.write_o(write_o),
		.F_sel(F_sel),
		.B_sel(B_sel)
	);
	
	// Signal Generation
	
	// CLK generation
	initial
	begin
		clk = 1'b0;
		forever #half_period clk = ~clk;
	end
	
	// RSTN generation (synchronous with clk and active-low)
	initial
	begin
		rstn = 1'b0; // Active-high at 0ns
//		#20 rstn = 1'b0; // Active-low at 20ns
		#35 rstn = 1'b1; // Active-high again at 70ns
	end
	
	// External Button (act as enable)
	initial
	begin
		ex_btn = 1'b0;
		#220 ex_btn = 1'b1;
	end
	
//	// Input and Output operation of opcode
//	// Txt file later on
	initial
	begin
		// Read the memory of txt file created for data implementation
		$readmemb("opcode_data.txt", opcode_data);
		$readmemb("write_a_data.txt", write_a_data);
		$readmemb("write_b_data.txt", write_b_data);
		$readmemb("write_o_data.txt", write_o_data);
		$readmemb("F_sel_data.txt", F_sel_data);
		$readmemb("B_sel_data.txt", B_sel_data);
		#25; // Should not collide with clk rising edge trigger
		
		// Monitor to display the state and value of those variables
		$monitor("Opcode = %b, rstn = %b, ex_btn = %b =>> write_a = %b, write_b = %b, write_o = %b, F_sel = %b, B_sel = %b", opcode, rstn, ex_btn, write_a, write_b, write_o, F_sel, B_sel);
		
		// Display error if needed
		// Imitiating all of the value of the text file to the corresponding test bench data
		for (int i = 0; i < 256; i++)
		begin
			opcode = opcode_data[i]; // Only reads and pass the input value
		
		// Check if there is an error using assert
			#6;
			assert (write_a == write_a_data[i])
				else
				begin
					$display("Error: wrong output write_a = %b compared to write_a_data = %b", write_a, write_a_data[i]);
				end
				
			assert (write_b == write_b_data[i])
				else
				begin
					$display("Error: wrong output write_b = %b compared to write_b_data = %b", write_b, write_b_data[i]);
				end
				
			assert (write_o == write_o_data[i])
				else
				begin
					$display("Error: wrong output write_o = %b compared to write_o_data = %b", write_o, write_o_data[i]);
				end
				
			assert (F_sel == F_sel_data[i])
				else
				begin
					$display("Error: wrong output F_sel = %b compared to F_sel_data = %b", F_sel, F_sel_data[i]);
				end
				
			assert (B_sel == B_sel_data[i])
				else
				begin
					$display("Error: wrong output B_sel = %b compared to B_sel_data = %b", B_sel, B_sel_data[i]);
				end
			#14;
		end
	end

//	initial
//	begin
//		$readmemb("opcode_data.txt", opcode_data);
//		#25;
//		
//		$monitor("Opcode = %b, rstn = %b, ex_btn = %b =>> write_a = %b, write_b = %b, write_o = %b, F_sel = %b, B_sel = %b", opcode, rstn, ex_btn, write_a, write_b, write_o, F_sel, B_sel);
//
//		for (int i = 0; i < 256; i++)
//		begin
//			opcode = opcode_data[i];
//			#25;
//		end
//	end

//	begin
//		#65 opcode = 4'b0000;
//		#25 opcode = 4'b0001;
//		#25 opcode = 4'b0010;
//		#25 opcode = 4'b0011;
//		#25 opcode = 4'b0100;
//		#25 opcode = 4'b0101;
//		#25 opcode = 4'b0110;
//		#25 opcode = 4'b0111;
//		#25 opcode = 4'b1000;
//		#25 opcode = 4'b1001;
//		#25 opcode = 4'b1010;
//		#25 opcode = 4'b1011;
//	end
		
endmodule
