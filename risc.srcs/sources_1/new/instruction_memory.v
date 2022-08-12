`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2021 10:20:23
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(address
,instruction );
   input [5:0] address;
   output [31:0] instruction;
   reg [31:0] RAM[0:63];
   initial $readmemh("C:/Users/bedri/Desktop/risc-v/risc/inst_mem.txt", RAM);
   assign instruction = RAM[address];
endmodule
