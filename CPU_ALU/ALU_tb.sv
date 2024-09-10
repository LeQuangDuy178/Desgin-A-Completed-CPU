`timescale 1ns/1ps

module ALU_tb();

	// Testbench Parameter
	parameter half_period = 10; // f = 50 MHz
	logic [7:0] A_bus_in, B_bus_in;
	logic [3:0] F_sel;
	logic [7:0] C_out;
	logic CF_out, ZF_out;
	
	// Data in txt for automation
	logic [7:0] A_bus_data[0:255], B_bus_data[0:255]; // an array of 256 8-bit elements (256 maximum cases)
	logic [3:0] F_data[0:255]; // F selection data
	logic [7:0] C_expected[0:255]; // Output expected
	logic CF_expected[0:255], ZF_expected[0:255];
	
	// Instantiate module for ALU testbench
	ALU ALU_testing_0 (.A_bus(A_bus_in), .B_bus(B_bus_in), .F(F_sel), .C(C_out), .CF(CF_out), .ZF(ZF_out));
	
	// Signal generation
	// A_bus and B_bus generation
	initial
	begin
//		$readmemb("A_data.txt", A_bus_data);
//		$readmemb("B_data.txt", B_bus_data);
//		$readmemb("F_data.txt", F_data);
//		$readmemb("C_data.txt", C_expected);
//		$readmemb("CF_data.txt", CF_expected);
//		$readmemb("ZF_data.txt", ZF_expected);
		
		$readmemb("A_data1.txt", A_bus_data);
		$readmemb("B_data1.txt", B_bus_data);
		$readmemb("F_data.txt", F_data);
		$readmemb("C_data1.txt", C_expected);
		$readmemb("CF_data1.txt", CF_expected);
		$readmemb("ZF_data1.txt", ZF_expected);
		
		#25; // Read to 25 ns (25 ns for every F_selection)
		
		$monitor("A = %b, B = %b, F = %b, C = %b, CF = %b, ZF = %b", A_bus_in, B_bus_in, F_sel, C_out, CF_out, ZF_out);
	
		for (int i = 0; i < 256; i++)
		begin
			A_bus_in = A_bus_data[i];
			B_bus_in = B_bus_data[i];
			F_sel = F_data[i];
	
			#6; // At 6 ns
			assert (C_out == C_expected[i])
				else
				//$error("failed");
				begin
					$display ("At ", $time, "ns");
					$display ("Error: input a= %b and input b = %b with F = %b", A_bus_in, B_bus_in, F_sel);
					$display ("generated ouput = %b differs from expected output %b", C_out, C_expected[i]);
				end
			
			assert (CF_out == CF_expected[i])
				else
				begin
					$display ("Error: wrong output CF = %b, compared to expected CF = %b", CF_out, CF_expected[i]);
				end
			
			assert (ZF_out == ZF_expected[i])
				else
				begin
					$display ("Error: wrong output ZF = %b, compared to expected ZF = %b", ZF_out, ZF_expected[i]);
				end
			#14;
		end
	end
			
endmodule
