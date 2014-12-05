`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
//
// Design Name: SPI_LCD
// Module Name: test_SPI_LCD.v
// Project Name: SPI_LCD
// Target Device:  XC2C256-7-TQ144
// Description: Verilog Test Fixture created by ISE for module: SPI_LCD
// 
////////////////////////////////////////////////////////////////////////////////

module test_SPI_LCD;

	// Inputs
	reg clk;
	reg [3:0] rows;
	reg MISO;

	// Outputs
	wire MOSI;
	wire SCLK;
	wire SS;
	wire [3:0] cols;

	// Instantiate the Unit Under Test (UUT)
	SPI_LCD uut (
		.clk(clk), 
		.rows(rows), 
		.MISO(MISO), 
		.MOSI(MOSI), 
		.SCLK(SCLK), 
		.SS(SS), 
		.cols(cols)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rows = 0;
		MISO = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
        #100000 $stop;
	end
    
    always begin
        #62.5 clk = ~clk;
    end
    
endmodule

