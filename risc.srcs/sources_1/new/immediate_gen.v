`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2021 09:49:24
// Design Name: 
// Module Name: immediate_gen
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


module immediate_gen(instruction,immediate_data

    );
    
    input [31:0] instruction;
    output reg [31:0] immediate_data;
    
    wire   [6:0] opcode;
    
    assign opcode=instruction[6:0];
    
    always@(instruction)
    begin
    case(opcode )
                7'b0010011: immediate_data <= { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20]};   // ADDI     -> I-Type
        7'b0100011: immediate_data <= { {21{instruction[31]}}, instruction[30:25], instruction[11:8], instruction[7]};     // SW       -> S-Type
        7'b0010111: immediate_data <= { instruction[31], instruction[30:20], instruction[19:12], {12{1'b0}} };             // AUIPC    -> U-Type
        7'b0000011: immediate_data <= { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20]};   // LW       -> I-Type
        7'b1101111: immediate_data <= { {12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:25], instruction[24:21], {1{1'b0}}};  // JAL -> J-Type
        7'b1100011: immediate_data <= { {20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], {1{1'b0}}};  // BRANCH -> B-Type
        default: immediate_data <= 32'bx;
    endcase
    
    end 
endmodule
