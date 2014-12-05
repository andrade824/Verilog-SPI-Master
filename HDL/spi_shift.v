`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: 8-bit Shift Register with Parellel load/read
// Module Name: spi_shift 
// Project Name: SPI LCD Controller
// Target Devices: XC2C256-7-TQ144
// Description: 8-bit Shift Register with Parellel load/read
//
//////////////////////////////////////////////////////////////////////////////////
module spi_shift(
    input wire clk, rst,
    input wire shift_en, load, shift_in,
    input wire [6:0] data_in,
	output wire s_out
);
	reg [7:0] data;
	assign s_out = data[7];
	
    always @(negedge clk or posedge rst) begin
        if (rst)
			data = 8'b0;
		else if(load)
            data = {1'b0, data_in};
        else if (shift_en)
            data = {data[6:0], shift_in};
        else
            data = data;
    end

endmodule
