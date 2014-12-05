`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: SPI Master Controller
// Module Name: spi_master 
// Project Name: SPI LCD Controller
// Target Devices: XC2C256-7-TQ144
// Description: This is a master controller for the Serial Peripheral Interface bus 
//
//////////////////////////////////////////////////////////////////////////////////
module spi_master(
    input wire clk, rst,
    input wire [6:0] data_in,
    input wire MISO, send,
    output wire MOSI, SCLK, SS, done
);
    wire shift_en, load;
    
    spi_shift shift(
        .clk(clk), 
        .rst(rst), 
        .shift_en(shift_en), 
        .load(load), 
        .shift_in(MISO), 
        .data_in(data_in), 
        .s_out(MOSI)
    );
    
    spi_ctrl ctrl(
        .clk(clk),
        .rst(rst),
        .send(send),
        .shift_en(shift_en),
        .done(done),
		.load(load),
        .SCLK(SCLK),
        .SS(SS)
    );

endmodule
