`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: SPI LCD Controller
// Module Name: SPI_LCD 
// Project Name: SPI LCD Controller
// Target Devices: XC2C256-7-TQ144
// Description: Top level design for SPI LCD Controller
//
//////////////////////////////////////////////////////////////////////////////////
module SPI_LCD(
	input wire clk,
    input wire [3:0] rows,
	input wire MISO, clear,
	output wire MOSI, SCLK, SS,
    output wire [3:0] cols
);

    wire clk_500KHz, clk_250KHz, clk_1KHz;
    wire key_data_ready, data_ready_synced, lcd_send;
    wire [6:0] encoder_out, lcd_data_out;
    wire clear_inv, spi_done;
    
    // Clear button is active low
    assign clear_inv = ~clear;
    
    // Divide the 8MHz clock to 500KHz
	CLK_DIV16 clock_divider (
		.CLKIN(clk),
		.CLKDV(clk_500KHz) );

    // Divide 500KHz to 125KHz and 1KHz
    clk_div clk_div(
        .clk(clk_500KHz),
        .clk_div_250khz(clk_250KHz),
        .clk_div_1khz(clk_1KHz)
    );
    
    keypad key (
        .clk(clk_1KHz), 
        .rows(rows), 
        .data_ready(key_data_ready), 
        .cols(cols), 
        .encoder_out(encoder_out)
    );
    
	synchronizer sync (
		.fast_clk(clk_250KHz), 
		.rst(1'b0), 
		.flag(key_data_ready), 
		.flag_out(data_ready_synced)
    );
	
    lcd_ctrl lcd (
        .clk(clk_250KHz), 
        .rst(1'b0), 
        .clear(clear_inv), 
        .spi_done(spi_done), 
        .key_data_out(encoder_out), 
        .key_send(data_ready_synced), 
        .data_out(lcd_data_out), 
        .send(lcd_send)
    );
    
    spi_master spi (
        .clk(clk_250KHz), 
        .rst(1'b0), 
        .data_in(lcd_data_out), 
        .MISO(MISO), 
        .send(lcd_send), 
        .MOSI(MOSI), 
        .SCLK(SCLK), 
        .SS(SS),
        .done(spi_done)
    );

endmodule
