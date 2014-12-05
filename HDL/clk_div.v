`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: Clock Divider
// Module Name: clk_div 
// Project Name: SPI LCD Controller
// Target Devices: XC2C256-7-TQ144
// Description: 500KHz to 1KHz and 250KHz clock divider
//
//////////////////////////////////////////////////////////////////////////////////
module clk_div(
    input wire clk,
    output reg clk_div_250khz,
    output reg clk_div_1khz
);

    wire c_tog_1khz;
	reg [7:0] count_1khz;
    
	assign c_tog_1khz = (count_1khz == 8'b11111010);
    
    // For simulations
    initial begin
        count_1khz = 8'b0;
        clk_div_1khz = 1'b0;
        clk_div_250khz = 1'b0;
    end
    
	// 1KHz clock divider
	always @(posedge clk)
	begin
        if(count_1khz < 8'b11111010)
			count_1khz = count_1khz + 1'b1;
		else
			count_1khz = 8'b0;
	end
	
	always @(negedge clk)
	begin
        if(c_tog_1khz == 1'b1)
			clk_div_1khz = ~clk_div_1khz;
		else
			clk_div_1khz = clk_div_1khz;
	end
    
    // 250KHz clock divider
	always @(negedge clk)
	begin
			clk_div_250khz = ~clk_div_250khz;
	end
	
endmodule