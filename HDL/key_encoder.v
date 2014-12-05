`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:        Devon Andrade
// 
// Design Name:     Encoder
// Module Name:     key_encoder 
// Project Name:    Keypad Controller
//
//////////////////////////////////////////////////////////////////////////////////
module key_encoder(
	input wire [5:0] data_in,
	output reg [6:0] out
);

    always @ (*) begin
        case(data_in)
            6'b001110: out = 7'h41; // col 0, row 0
			6'b001101: out = 7'h42; // col 0, row 1
			6'b001011: out = 7'h43; // col 0, row 2
			6'b000111: out = 7'h44; // col 0, row 3
			6'b011110: out = 7'h33; // col 1, row 0
			6'b011101: out = 7'h36; // col 1, row 1
			6'b011011: out = 7'h39; // col 1, row 2
			6'b010111: out = 7'h45; // col 1, row 3
			6'b101110: out = 7'h32; // col 2, row 0
			6'b101101: out = 7'h35; // col 2, row 1
			6'b101011: out = 7'h38; // col 2, row 2
			6'b100111: out = 7'h46; // col 2, row 3
			6'b111110: out = 7'h31; // col 3, row 0
			6'b111101: out = 7'h34; // col 3, row 1
			6'b111011: out = 7'h37; // col 3, row 2
			6'b110111: out = 7'h30; // col 3, row 3
			default: out = 7'h30;
        endcase
    end
    
endmodule
