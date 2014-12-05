`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: Synchronizer
// Module Name: synchronizer 
// Project Name: SPI LCD Controller
// Target Devices: XC2C256-7-TQ144
// Description: Synchronizes a signal coming out from a slower clock, to a faster one
//
//////////////////////////////////////////////////////////////////////////////////
module synchronizer(
	input wire fast_clk, rst,
	input wire flag,
	output wire flag_out
);

	reg flagger1, flagger2;
	
	// Create pulse on rising edge of "flag" signal
	assign flag_out = flagger1 & ~flagger2;
	
	initial begin
		flagger1 = 1'b0;
		flagger2 = 1'b0;
	end
	
	always @(negedge fast_clk or posedge rst) begin
		if(rst) begin
			flagger1 <= 1'b0;
			flagger2 <= 1'b0;
		end else begin
			flagger1 <= flag;
			flagger2 <= flagger1;
		end
	end

endmodule
