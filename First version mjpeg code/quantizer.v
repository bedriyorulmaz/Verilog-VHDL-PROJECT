`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2021 13:29:50
// Design Name: 
// Module Name: quantizer
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


module quantizer(
    input clk,
    input [7:0] data,
    input [5:0] data_add,
    output reg [7:0]   d_out,
    output reg enable
    );
 reg [7:0] data_out;   
 reg[5:0]quantizer[0:63]    ; //quantizer
  initial $readmemh("quantizer.txt", quantizer);   
  
  always@(data)
  begin
    data_out <= data / quantizer[data_add];
   d_out <=     data_out;
   enable <= 1'b1;
  end 
endmodule
