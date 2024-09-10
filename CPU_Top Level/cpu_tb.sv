`timescale 1ns/1ps

module cpu_tb();

	// Input Output
	logic clk, rstn;
	logic ex_btn;
	logic [3:0] op_code;
	logic [7:0] ext_data;
	logic [7:0] OUT_reg;
	logic CF, ZF;
	
	// Module instantiation
	cpu top_level_testing_0 (
		.clk(clk),
		.rstn(rstn),
		.ex_btn(ex_btn),
		.op_code(op_code),
		.ext_data(ext_data),
		.OUT_reg(OUT_reg),
		.CF(CF),
		.ZF(ZF)
	);
	
	// Data for automation testing (with testing cases in section 3.5)
	logic [3:0] op_code_data[0:255]; // With ext_data = 8'b01000010
	logic [7:0] OUT_reg_expected[0:255];
	
	// Logic expression
	
	// clk signal
	initial
	begin
		clk = 1'b0;
		forever #10 clk = ~clk; // Period is T = 20ns (with freq = 50MHz)
	end
	
	// rstn signal (active-low)
	initial
	begin
		rstn = 1'b0;
//		#20 rstn = 1'b0;
		#35 rstn = 1'b1;
	end
	
	// ex_btn signal (logic low)
	initial
	begin
		ex_btn = 1'b0;
//		forever #16 ex_btn = ~ex_btn;
//		#55 ex_btn = 1'b1; // Not trigger INCA
//		#20 ex_btn = 1'b0;
	end
	
	// ext_data
	initial
	begin
		ext_data = 8'b01000010;
	end
	
	// CF and ZF will be automatically created through the inputs
	
	// op_code and OUT_reg (read data)
	initial
	begin
		#15
		$readmemb("op_code_data.txt", op_code_data);
		$readmemb("OUT_reg_expected.txt", OUT_reg_expected);
		#20;
		
		// Display
		$monitor("op_code = %b, ext_data = %b, then OUT_reg = %b, CF = %b, ZF = %b", op_code, ext_data, OUT_reg, CF, ZF);
		
		// Assert to detect error and loop data
		for (int i = 0; i < 256; i++)
		begin
			op_code = op_code_data[i];
//			OUT_reg = OUT_reg_expected[i];
			
			#6;
			assert(OUT_reg == OUT_reg_expected[i])
				else
				begin
					$display("Error: wrong output OUT_reg = %b, compared to expected OUT_reg = %b", OUT_reg, OUT_reg_expected[i]);
				end
			#14;
		end
	end

	// Opcode manual (instruction in assessment note)
//	initial
//	begin
//		op_code = 4'bxxxx;
//		#15 op_code = 4'b0001;
//		#20 op_code = 4'b0110;
//		#20 op_code = 4'b0100;
//		#20 op_code = 4'b0100;
//		#20 op_code = 4'b0100;
//		#20 op_code = 4'b0011;
//		#20 op_code = 4'b1010;
//		#20 op_code = 4'b0010;
//	end
	
		// Opcode manual (customize gom gom)
//	initial
//	begin
//		op_code = 4'bxxxx;
//		#15 op_code = 4'b0001;
//		#20 op_code = 4'b0110;
//		#20 op_code = 4'b0101;
//		#20 op_code = 4'b0100;
//		#20 op_code = 4'b0110;
//		#20 op_code = 4'b0011;
//		#20 op_code = 4'b1010;
//		#20 op_code = 4'b0010;
//	end
	
endmodule
