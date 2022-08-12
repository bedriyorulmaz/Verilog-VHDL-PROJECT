`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2021 09:20:40
// Design Name: 
// Module Name: program_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module program_counter(clk,reset,pc_in,pc_out

    );
    input clk,reset;
    input [31:0]pc_in;
    output reg [31:0] pc_out;
    parameter bit = 32;
    parameter INCREMENT = 32'h00000004;
    always@(posedge clk or posedge reset) 
    begin
        if(reset ==1'b1)
            pc_out<=0;
        else 
            pc_out<=pc_in+INCREMENT;     
    
    
    end
endmodule
