`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2021 13:13:09
// Design Name: 
// Module Name: dequantizer
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


module dequantizer(
    input clk,
    input [7:0] data,
    input [5:0] data_add,
    output reg [7:0]   d_out,
    output reg [5:0] addra
    );
 reg [7:0] data_out;   
 reg[5:0]quantizer[0:63]    ; //quantizer
  initial $readmemh("quantizer.txt", quantizer);   
  
  always@(data)
  begin
    data_out <= data * quantizer[data_add];
   d_out <=     data_out;
   addra <= data_add;
  end 
endmodule
