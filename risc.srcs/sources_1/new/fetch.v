`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2021 11:34:29
// Design Name: 
// Module Name: fetch
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


module fetch(clk,reset,ADD_result,selbranch,jump,ALUout,instruction,pc_out_t

    );
    
    
    input [31:0]ADD_result,ALUout;
    input selbranch ,clk,reset,jump;
    
    output [31:0] instruction;
    output    [31:0] pc_out_t;
    
    wire [31:0] next_pc_mux;
    wire [31:0]next_pc;
    wire [31:0]pc_4,pc_out;
     
    assign next_pc_mux=(selbranch==1)?ADD_result:pc_4;
    assign next_pc=(jump==1)?ALUout:next_pc_mux;
    
    program_counter u0 (clk,reset,next_pc,pc_out  );
    
   adder u1 (pc_out, 32'h00000000,  pc_4);
   
 instruction_memory u2(pc_out[7:2],instruction );
  assign pc_out_t=pc_out;

    
endmodule


module adder(a, b,  out);
   input[31:0] a, b;
   output[31:0] out;
   assign out = OUT(a, b);

   function [31:0] OUT;
       input [31:0] a, b;
       begin
       casex(b[31])
           1'b1:   begin
                   b = ~b;
                   b = b + 1'b1;
                   OUT = a - b;
                   end
           default: OUT = a + b;
       endcase
     end
   endfunction
endmodule
