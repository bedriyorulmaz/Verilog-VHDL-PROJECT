`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2021 12:09:12
// Design Name: 
// Module Name: inst_decode
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


module inst_decode(clk,write_data,RegWrite,
             instruction,read_data,read_data2

    );
    wire [4:0] regread1,regread2,reg_dest;
    input  RegWrite,clk; 
    input [31:0] instruction,write_data;
    output reg [31:0]  read_data,read_data2;
    
    reg [31:0] file_reg[31:0];
     wire [31:0] inst;
      assign inst = instruction;
      
    assign regread1=inst[19:15];
    assign regread2=inst[24:20];
    assign reg_dest=inst[11:7];
    
    always@(negedge clk  )
         if (RegWrite==1) 
            file_reg[reg_dest] <= write_data;
    always@(regread1) 
        if(regread1!=0)
            read_data <= file_reg[regread1];
        else
            read_data <=0;           
 
     always@(regread2) 
        if(regread1!=0)
            read_data2 <= file_reg[regread2];
        else
            read_data2 <=0;   
endmodule
