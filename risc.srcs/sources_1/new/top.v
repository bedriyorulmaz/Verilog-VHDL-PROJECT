`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2021 09:35:31
// Design Name: 
// Module Name: top
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


module top(clk,reset  );
input clk,reset;
wire [31:0] immediate_data,read_data,read_data2,a,b,write_data,readData;
wire [31:0]instruction,ALUout,pc_out,ADD_result;
wire zero, LSb_aluresult, memtoreg, memwrite, memread, selBranch, alusrcA, alusrcB, regwrite,   jump ;
wire [3:0] aluctrl;
wire [2:0] mem_cntrl;
fetch u0 (clk,reset,ADD_result,selBranch,jump,ALUout,instruction,pc_out );

controller u1(instruction[6:0], instruction[31:25], instruction[14:12], zero, LSb_aluresult, memtoreg, memwrite, memread, selBranch, alusrcA, alusrcB, regwrite, aluctrl, jump,mem_cntrl);

adder   u2(immediate_data, pc_out,  ADD_result);
immediate_gen  u3(instruction,immediate_data  );

assign a=(alusrcA==1)?read_data:pc_out;
assign b=(alusrcB==1)?immediate_data:read_data2;

alu u4(a, b, aluctrl,  ALUout, zero, LSb_aluresult);
inst_decode  u5(clk,write_data,regwrite, instruction,read_data,read_data2 );
assign write_data=(memtoreg==1)?readData:ALUout;
dataMemory  u6(clk, memwrite,memread, ALUout[5:0], read_data2, readData,mem_cntrl);
endmodule
