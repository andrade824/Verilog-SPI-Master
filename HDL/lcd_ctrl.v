`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: LCD Controller
// Module Name: lcd_ctrl 
// Project Name: SPI LCD Controller
// Target Devices: XC2C256-7-TQ144
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module lcd_ctrl(
    input wire clk, rst,
    input wire clear, spi_done,
    input wire [6:0] key_data_out,
    input wire key_send,
    output reg [6:0] data_out,
    output reg send
);

    localparam [2:0]
        Init = 3'b000,
        Clr1 = 3'b001,
        Clr1Wait = 3'b010,
        Clr2 = 3'b011,
        Clr2Wait = 3'b100,
        Clr3 = 3'b101,
        Clr3Wait = 3'b110;
        
    reg [2:0] cstate, nstate;

    always @(posedge clk or posedge rst) begin
        if(rst)
            cstate = Init;
        else
            cstate = nstate;
    end
    
    always @(*) begin
        case(cstate)
            Init : begin
                data_out = key_data_out;
                send = key_send;
                
                if(clear)
                    nstate = Clr1;
                else
                    nstate = cstate;
            end
            
            Clr1 : begin
                data_out = 7'h1B;
                send = 1'b1;
                
                nstate = Clr1Wait;
            end
            
			Clr1Wait : begin
				data_out = 7'h1B;
                send = 1'b0;
				
				if(spi_done)
                    nstate = Clr2;
                else
                    nstate = cstate;
			end
			
            Clr2 : begin
                data_out = 7'h5B;
                send = 1'b1;
                
                nstate = Clr2Wait;
            end
            
			Clr2Wait : begin
				data_out = 7'h5B;
                send = 1'b0;
				
				if(spi_done)
                    nstate = Clr3;
                else
                    nstate = cstate;
			end
            
            Clr3 : begin
                data_out = 7'h6A;
                send = 1'b1;
                
                nstate = Clr3Wait;
            end
            
			Clr3Wait : begin
				data_out = 7'h6A;
                send = 1'b0;
				
				if(spi_done)
                    nstate = Init;
                else
                    nstate = cstate;
			end
            
            default : begin
                data_out = 8'b0;
                send = 1'b0;
                
                nstate = Init;
            end
        endcase
    end

endmodule
