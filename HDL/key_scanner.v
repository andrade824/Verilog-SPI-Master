`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////  
// Engineer: Devon Andrade
// 
// Design Name: Scanner
// Module Name: scanner 
// Project Name: Keypad Controller
// Target Devices: XC2C256
// Description: This module outputs a key enable signal when a key is pressed
//                     along with driving the columns.
//////////////////////////////////////////////////////////////////////////////////
module key_scanner(
    input wire clk,
	input wire [3:0] rows,
	output wire ken,
    output reg [1:0] count,
    output reg [3:0] cols
);
    // High with no buttons pressed, low when button pressed
    assign ken = &(rows);

    // For Simulation
    initial begin
        count = 2'b0;
    end

    // 2-bit counter
    always @(posedge clk)
    begin
        if(ken)
            count = count + 1;
        else
            count = count;
    end

    // Column decoder
    always @(*) begin
        if(~ken)
            cols = 4'b0000;
        else begin
            case(count)
                2'b00 : cols = 4'b0111;
                2'b01 : cols = 4'b1011;
                2'b10 : cols = 4'b1101;
                2'b11 : cols = 4'b1110;
                default : cols = 4'bxxxx;
            endcase
        end
    end

endmodule
