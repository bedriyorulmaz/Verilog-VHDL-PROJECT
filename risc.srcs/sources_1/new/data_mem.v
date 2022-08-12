`timescale 1ns / 1ps
module dataMemory(clock, writeEnable,read_enable, address, writeData, readData,mem_cntrl);
   input clock, writeEnable,read_enable;
   input[5:0] address;
   input[2:0] mem_cntrl;
   input[31:0] writeData;
   output reg [31:0] readData;
   reg [31:0] RAM2[0:63];
   always @(posedge clock)
   begin
   if (writeEnable)
   begin
     case(mem_cntrl) 
        3'b000:    RAM2[address[5:2]] <= writeData[7:0];
        3'b001:     RAM2[address[5:2]] <= writeData[15:0];
         3'b010:    RAM2[address[5:2]] <= writeData ;
          
   endcase
   end
   if (read_enable) 
   begin
     case(mem_cntrl) 
        3'b000: begin 
                if(RAM2[address[5:2]][31])
                    readData <= {{24{RAM2[address[5:2]][31]}},RAM2[address[5:2]][7:0]}; //LB
                else
                    readData <= {{24{1'b0}},RAM2[address[5:2]][7:0]}; //LB

                end
        3'b001: begin 
                if(RAM2[address[5:2]][31])
                    readData <= {{16{RAM2[address[5:2]][31]}},RAM2[address[5:2]][15:0]}; //LH
                else
                    readData <= {{16{1'b0}},RAM2[address[5:2]][15:0]}; //LH

                end //LH
        3'b010: readData <= RAM2[address[5:2]]; //LW
        3'b011:   readData <= {{24{1'b0}},RAM2[address[5:2]][7:0]}; //LBU
                   
        3'b100:  readData <= {{16{1'b0}},RAM2[address[5:2]][15:0]}; //LHU

        default :readData <= RAM2[address[5:2]];
    
        endcase
   end
   end
endmodule
