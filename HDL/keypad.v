`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: Keypad Controller
// Module Name: keypad 
// Project Name: Keypad Controller
// Target Devices: XC2C256
// Description: The Keypad scanning and encoding portion of the Keypad Controller
//////////////////////////////////////////////////////////////////////////////////
module keypad(
    input wire clk,
    input wire [3:0] rows,
    output wire data_ready,
    output wire [3:0] cols,
    output wire [6:0] encoder_out
);

    wire [1:0] count;
    wire ken, latch_en;
    wire [5:0] latch_out;
    
    // Keypad State Machine
    key_ctrl key_ctrl (
        .clk(clk),
        .ken(ken),
        .data_ready(data_ready),
        .latch_en(latch_en)
    );
    
    // Scanner
    key_scanner scan (
        .clk(clk),
        .rows(rows),
        .ken(ken),
        .count(count),
        .cols(cols)
    );

    // Data Latch
    key_latch latch(
        .clk(clk),
        .rows(rows),
        .cols(count),
        .latch_en(latch_en),
        .data_out(latch_out)
    );

    // Encoder
    key_encoder enc (
        .data_in(latch_out),
        .out(encoder_out)
    );

endmodule
