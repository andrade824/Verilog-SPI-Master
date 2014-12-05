`timescale 1us / 1us

////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
//
// Design Name:   spi_master
// Module Name:   test_spi_master.v
// Project Name:  SPI_LCD
// Target Device: XC2C256-7-TQ144
// Description: Verilog Test Fixture created by ISE for module: spi_master
// 
////////////////////////////////////////////////////////////////////////////////

module test_spi_master (
	// Inputs
	output reg clk,
	output reg rst,
	output reg [6:0] data_in,
	output reg MISO,
	output reg send,

	// Outputs
	output wire MOSI,
	output wire SCLK,
	output wire SS,
	output wire done
);

	// Instantiate the Unit Under Test (UUT)
	spi_master uut (
		.clk(clk), 
		.rst(rst), 
		.data_in(data_in), 
		.MISO(MISO), 
		.send(send), 
		.MOSI(MOSI), 
		.SCLK(SCLK), 
		.SS(SS), 
		.done(done)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		data_in = 7'h31;
		MISO = 1;
		send = 0;
        
		// Add stimulus here
        #6 send = 1;
        #6 send = 0;
        #120 $stop;
	end
    
    always begin
        #3 clk = ~clk;
    end
    
endmodule

