`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.08.2021 11:30:18
// Design Name: 
// Module Name: tb_control
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


module tb_control;
 
 reg reset_; initial begin reset_=1; #22 reset_=0; #140 $stop; end
   reg clock;  initial clock=0; always #5 clock<=(!clock);
 
 top Cpu(clock,reset_);
//    reg [6:0] opcode, funct7;
//    reg [2:0] funct3;

//    reg zero, LSb_aluresult;
    
//    wire memtoreg, memwrite, memread, selBranch, alusrcA, alusrcB, regwrite,jump;
    
//   wire [2:0] mem_cntrl;
//   wire [3:0] alucontrol;
//   controller u1 (opcode, funct7, funct3, zero, LSb_aluresult, memtoreg, memwrite, memread, selBranch, alusrcA, alusrcB, regwrite, alucontrol, jump,mem_cntrl);

//    initial
//    begin
    
//    opcode<=7'b1100011;
//    funct3<=3'b000;
//    funct7<=7'b0000000;
//    zero<=1'b0;
//    LSb_aluresult<=1'b0;
    
//    #5
//     opcode<=7'b1100011;
//    funct3<=3'b000;
//    funct7<=7'b0000000;
//    zero<=1'b1;
//    LSb_aluresult<=1'b1;
    
//    #5   
//    opcode<=7'b1100011;
//    funct3<=3'b001;
//    funct7<=7'b0000000;

//     #5
    
//    opcode<=7'b1100011;
//    funct3<=3'b100;
//    funct7<=7'b0000000;
    
//    #5
    
//    opcode<=7'b1100011;
//    funct3<=3'b101;
//    funct7<=7'b0000000;       
//     #5
    
//    opcode<=7'b1100011;
//    funct3<=3'b110;
//    funct7<=7'b0000000; 
    
//    #5
    
//    opcode<=7'b1100011;
//    funct3<=3'b111;
//    funct7<=7'b0000000;      
//    end

endmodule
