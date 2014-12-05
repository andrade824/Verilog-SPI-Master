Verilog SPI Master
==================

This project consists of a custom SPI Master IP which is used to communicate with the <a href="https://www.digilentinc.com/Products/Detail.cfm?NavPath=2,401,473&Prod=PMOD-CLS">PmodCLS</a> serial LCD screen (it supports I2C, SPI, and UART interfaces). This project also has a keypad scanner (the exact keypad used is the <a href="http://www.digilentinc.com/Products/Detail.cfm?Prod=PMODKYPD">Digilent PmodKYPD keypad</a>) that scans a keypad and outputs whatever key was pressed onto the LCD.

The following modules were used in this design:
<strong>SPI_LCD:</strong> This is the top level module that ties the other modules together
<ul>
	<li><strong>keypad:</strong> This module contains the keypad scanning and control units</li>
	<ul>
		<li><strong>key_ctrl:</strong> State machine that controls the keypad scanning/latching and encoding</li>
		<li><strong>key_scanner:</strong> Pulls each column signal low consecutively until a button is pressed (in which case it pulls the "ken" signal low)</li>
		<li><strong>key_latch:</strong> This latches the data until it's ready to be shifted</li>
		<li><strong>key_encoder:</strong> This converted the row and column outputs to a usable ascii value for the LCD display</li>
	</ul>
	<li><strong>synchronizer:</strong> This synchronizes the 1KHz data_ready signal to a 250KHz clock</li>
	<li><strong>clk_div:</strong> This divides the 500KHz clock down to 1KHz and 250KHz respectively</li>
	<li><strong>lcd_ctrl:</strong> This state machine controls whether to send data to the LCD, or the clear sequence (when the clear button is pressed)</li>
	<li><strong>spi_master:</strong> Module responsible for sending data over SPI</li>
	<ul>
		<li><strong>spi_shift:</strong> SPI Shift register to hold incoming and outgoing data</li>
		<li><strong>spi_ctrl:</strong> Controls when and what data is sent over SPI</li>
	</ul>
</ul>

This project was designed to be used on the <a href="http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,1000&Prod=CR2-STARTER">Digilent CoolRunner-II development board</a>, but should be able to be synthesized with most CPLDs (pinouts and other constraints will obviously change). The only other thing that will need to be changed is the fact that I'm using a built-in clock divider (specific to the CoolRunner-II chips) to divide down the clock by 16 before running it into my clock divider to further divide it. When you synthesize for your own chip, the clock divider module will need to be modified for whatever clock you'll be using.