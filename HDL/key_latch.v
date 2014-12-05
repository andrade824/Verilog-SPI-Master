`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: Keypad Data Latch
// Module Name: key_latch 
// Project Name: Keypad Controller
// Target Devices: XC2C256
// Description: Stores the currently pressed key data until it can be shifted.
//
//////////////////////////////////////////////////////////////////////////////////
module key_latch(
	input wire clk,
	input wire latch_en,
    input wire [3:0] rows,
    input wire [1:0] cols,
	output reg [5:0] data_out
);

    // For Simulations
    initial begin
        data_out = 6'b0;
    end

	always @(posedge clk) begin
		if(latch_en)
            data_out = {cols,rows};
        else
            data_out = data_out;
	end

endmodule
