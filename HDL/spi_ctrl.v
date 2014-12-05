`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: SPI Controller
// Module Name: spi_ctrl 
// Project Name: SPI LCD Controller
// Target Devices: XC2C256-7-TQ144
// Description: State machine for SPI Master controller
//
//////////////////////////////////////////////////////////////////////////////////
module spi_ctrl(
    input wire clk, rst,
    input wire send,
    output reg shift_en, done, SS, load,
    output wire SCLK
);

    localparam [2:0]
        Init = 3'b000,
        Load = 3'b001,
        Shift = 3'b010,
        Done = 3'b011,
        Wait = 3'b100;
        
    reg [2:0] cstate, nstate;
    reg [2:0] count;
    reg clk_en;
    
    // Only output the clock when needed
    assign SCLK = clk_en & clk;
    
    always @(posedge clk or posedge rst) begin
        if(rst)
            cstate = Init;
        else
            cstate = nstate;
    end

    always @(negedge clk or posedge rst) begin
        if(rst)
            count = 3'b111;
        else if (cstate == Shift)
            count = count + 1;
        else
            count = 3'b111;
    end
    
    always @(*) begin
        case(cstate)
            Init : begin
                {shift_en,load,done,SS} = 4'b0001;
                clk_en = 1'b0;
                
                if(send)
                    nstate = Load;
                else
                    nstate = cstate;
            end
            
            Load : begin
                {shift_en,load,done,SS} = 4'b0101;
                clk_en = 1'b0;
                
                nstate = Wait;
            end
            
			Wait : begin
				{shift_en,load,done,SS} = 4'b0000;
				clk_en = 1'b0;
				
				nstate = Shift;
			end
			
            Shift : begin
                {shift_en,load,done,SS} = 4'b1000;
                clk_en = 1'b1;
                
                if(count == 3'b111)
                    nstate = Done;
                else
                    nstate = cstate;
            end
            
            Done : begin
                {shift_en,load,done,SS} = 4'b0011;
                clk_en = 1'b0;
                
                if(send)
                    nstate = Load;
                else
                    nstate = cstate;
            end
            
            default : begin
                {shift_en,load,done,SS} = 4'b0001;
                clk_en = 1'b0;
                
                nstate = Init;
            end
        endcase
    end
    
endmodule
