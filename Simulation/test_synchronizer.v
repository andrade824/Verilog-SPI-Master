`timescale 1us / 1ns

////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
//
// Design Name: synchronizer
// Module Name: test_synchronizer.v
// Project Name:SPI_LCD
// Target Device: XC2C256-7-TQ144
// Description: Verilog Test Fixture created by ISE for module: synchronizer
// 
////////////////////////////////////////////////////////////////////////////////

module test_synchronizer;

	// Inputs
	reg fast_clk;
	reg rst;
	reg flag;

	// Outputs
	wire flag_out;

	// Instantiate the Unit Under Test (UUT)
	synchronizer uut (
		.fast_clk(fast_clk), 
		.rst(rst), 
		.flag(flag), 
		.flag_out(flag_out)
	);

	initial begin
		// Initialize Inputs
		fast_clk = 0;
		rst = 0;
		flag = 0;

		// Wait 100 ns for global reset to finish
		#1;
		flag = 1;
		#100 flag = 0;
		#20 $stop;
	end
	
	always begin
		#1 fast_clk = ~fast_clk;
	end
	
endmodule

