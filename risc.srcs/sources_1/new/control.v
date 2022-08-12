`timescale 1ns / 1ps
module controller(opcode, funct7, funct3, zero, LSb_aluresult, memtoreg, memwrite, memread, selBranch, alusrcA, alusrcB, regwrite, alucontrol, jump,mem_cntrl);
   input[6:0] opcode;
   input[6:0] funct7;
   input[2:0] funct3;
   input zero;
   input LSb_aluresult; // Less significant bit of alu result
   output memtoreg, memwrite, memread, alusrcA, alusrcB ,regwrite, selBranch, jump;
   output [3:0] alucontrol;
    output [2:0]  mem_cntrl;
   wire [2:0] aluop;
   wire branch;

   maindec MainDec(opcode, memtoreg, memwrite, memread, jump, branch, alusrcA, alusrcB, regwrite, aluop, funct3,mem_cntrl);
   aludec  AluDec(funct7, funct3, aluop, alucontrol);

   // Branch selection
   wire beq_enable;
   wire blt_enable;
   wire bge_enable,bgtu_enable,bltu_enable;
   assign beq_enable = branch & zero;
   assign blt_enable = branch & LSb_aluresult;
   assign bge_enable =branch & (~LSb_aluresult);
      assign bltu_enable = branch & LSb_aluresult;
   assign bgeu_enable =branch & (~LSb_aluresult);
   
   // To avoid delay of the  2-input AND gate (propagation time = 60ps)
   assign selBranch = (opcode==7'b1100011) ? ( (funct3==3'b000) ? beq_enable :   
                                                (funct3==3'b100) ?   blt_enable:  
                                                (funct3==3'b001) ?   (~beq_enable):  
                                                    (funct3==3'b101) ?   bge_enable:  
                                                    (funct3==3'b110) ?   bgtu_enable:  
                                                    (funct3==3'b111) ?   bltu_enable:blt_enable ) :
                       
                      opcode==7'b0110011 ? 1'b0 :
                      opcode==7'b0000011 ? 1'b0 :
                      opcode==7'b0100011 ? 1'b0 :
                      opcode==7'b0010011 ? 1'b0 :
                      opcode==7'b0010111 ? 1'b0 :
                      opcode==7'b1101111 ? 1'b0 : 1'bx;
endmodule
module maindec(opcode, memtoreg, memwrite, memread, jump, branch, alusrcA, alusrcB, regwrite, aluop, funct3,mem_cntrl);
   input [6:0] opcode;
   input [2:0] funct3;
   output memtoreg, memwrite, memread, jump, branch, alusrcA, alusrcB, regwrite;
   output [2:0] aluop;
   output [2:0] mem_cntrl;
   reg [13:0] controls;
   assign {regwrite, alusrcA, alusrcB, jump, branch, memwrite, memread, memtoreg, aluop,mem_cntrl} = controls;
   always @(opcode or funct3)
   casex(opcode)
     7'b0110011: controls <= 14'b11000000111111;  // R-Type
     7'b0000011:  casex(funct3)
                   3'b000: controls <= 14'b11100011000000;  // LB
                   3'b001: controls <= 14'b11100011000001;  // LH
                   3'b010: controls <= 14'b11100011000010; // LW
                   3'b100: controls <= 14'b11100011000011;  // LBU
                    3'b101: controls <= 14'b11100011000100;  //LHU
                    
                   default: controls <= 14'bxxxxxxxxxxxxxx; // illegal op
                 endcase                                       //controls <= 10'b1110001100;  // LW
     7'b0100011:    casex(funct3)
                   3'b000: controls <= 14'b01100100000000;  // SB
                   3'b001: controls <= 14'b01100100000001;  // SH
                   3'b010: controls <= 14'b01100100000010; // SW
                
                    
                   default: controls <= 14'bxxxxxxxxxxxxxx; // illegal op
                 endcase                           //controls <= 14'b0110010000;  // SW
     
     
     7'b0010011:  casex(funct3)
                   3'b000: controls <= 14'b11100000000111;  // ADDI
                   3'b010: controls <= 14'b11100000010111;  // SLTI
                   3'b011: controls <= 14'b11100000011111; // SLTIU
                   3'b100: controls <= 14'b11100000100111; // XORI
                   3'b110: controls <= 14'b11100000101111; // ORI
                   3'b111: controls <= 14'b11100000110111; // ANDI
                   default: controls <= 14'bxxxxxxxxxxxxxx; // illegal op
                 endcase                                                //    14'b11100000000111;  // ADDI
     
     
     7'b0010111: controls <= 14'b10100000000111;  // AUIPC
     7'b1101111: controls <= 14'b00110000000111;  // JAL
     7'b1100011: casex(funct3)
                   3'b000: controls <= 14'b01001000001111;  // BEQ
                   3'b001: controls <= 14'b01001000001111;  // BNEQ
                   3'b100: controls <= 14'b01001000010111;  // BLT
                   3'b101: controls <= 14'b01001000010111;  // BGT
                 3'b110: controls <= 14'b01001000011111;  // BLTu
                   3'b111: controls <= 14'b01001000011111;  // BGTu
                   default: controls <= 14'bxxxxxxxxxxxxxx; // illegal op
                 endcase
     default: controls <= 14'bxxxxxxxxxxxxx; // illegal op
   endcase
endmodule

module aludec(funct7, funct3, aluop, alucontrol);
    input [6:0] funct7;
    input [2:0] funct3;
    input [2:0] aluop;
    output [3:0] alucontrol;
    reg [3:0] alucontrol;
    always @(aluop or funct7 or funct3)
    case(aluop)
      3'b000: alucontrol <= 4'b0010; //add (for lw/sw/addi/auipc/jal) 2
      3'b001: alucontrol <= 4'b1010; //sub (for beq) 10
      3'b010: alucontrol <= 4'b1011; //slt (for blt) 11
      3'b011: alucontrol <= 4'b1100;  // 12sltu
      3'b100: alucontrol <= 4'b0100;  // 4-xor
      3'b101: alucontrol <= 4'b0001;  // 1-or
      3'b110: alucontrol <= 4'b0000;  // 0-and
      3'bxxx: alucontrol <= 4'bxxxx;
      // R-type instructions
      default: casex(funct7)
        7'b0000000: casex(funct3)
		        3'b000: alucontrol <= 4'b0010; //add
		        3'b001: alucontrol <= 4'b1101; //SLL
                3'b010: alucontrol <= 4'b1011; //slt		        3'b011: alucontrol <= 4'b0010; //add
		        3'b100: alucontrol <= 4'b0100; //XOR
		        3'b101: alucontrol <= 4'b1110; //SRL
                3'b110: alucontrol <= 4'b0001; //or
		        3'b111: alucontrol <= 4'b0000; //and
		        
		        
                      default: alucontrol <= 4'bxxxx;
			endcase
	 7'b0100000: casex(funct3)
                      3'b000: alucontrol <= 4'b1010; //SUB
                      3'b101: alucontrol <= 4'b1111; //div
                      default: alucontrol <= 4'bxxxx;
		      endcase
	 default: alucontrol <= 4'bxxxx;	//illegal operation
       endcase
    endcase
endmodule