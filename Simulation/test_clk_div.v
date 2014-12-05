`timescale 1us / 1us

////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
//
// Design Name: clk_div
// Module Name: test_clk_div.v
// Project Name: SPI_LCD
// Target Device:  XC2C256-7-TQ144
// Description: Verilog Test Fixture created by ISE for module: clk_div
// 
////////////////////////////////////////////////////////////////////////////////

module test_clk_div;

	// Inputs
	reg clk;

	// Outputs
	wire clk_div_250khz;
	wire clk_div_1khz;

	// Instantiate the Unit Under Test (UUT)
	clk_div uut (
		.clk(clk), 
		.clk_div_250khz(clk_div_250khz), 
		.clk_div_1khz(clk_div_1khz)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
        
		#1;
        
		// Add stimulus here
        #6000 $stop;
	end
      
    always begin
        #1 clk  = ~clk;
    end
      
endmodule

