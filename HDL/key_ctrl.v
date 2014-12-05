`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: Keypad State Machine
// Module Name: keypad_controller 
// Project Name: Keypad Controller
// Target Devices: XC2C256
// Description: State machine for keypad
//
//////////////////////////////////////////////////////////////////////////////////
module key_ctrl (
	input wire clk,
	input wire ken,
	output reg data_ready,
	output reg latch_en
);

	reg [1:0] cstate, nstate;
	
	localparam [1:0]
				init = 2'b00,
				latch = 2'b01,
				shift = 2'b10,
				wt = 2'b11;
	
    // Power-up state
    initial begin
        cstate = init;
    end
    
	// Handle state changes
	always @(negedge clk) begin
        cstate = nstate;
    end
	
	// State machine
	always @(*)
	begin
		case(cstate)
			init : begin
				{latch_en,data_ready} = 2'b00;
				if(ken)
					nstate = cstate;
				else
					nstate = latch;
			end
			
			latch : begin
                {latch_en,data_ready} = 2'b10;
				nstate = wt;
			end
			
			wt : begin
				{latch_en,data_ready} = 2'b00;
				if(ken)
					nstate = shift;
				else
					nstate = cstate;
			end
			
			shift : begin
				{latch_en,data_ready} = 2'b01;
				nstate = init;
			end
			
			default : begin
				{latch_en,data_ready} = 2'b00;
				nstate = init;
			end
		endcase
	end
	
endmodule
