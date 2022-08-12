`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2021 12:54:50
// Design Name: 
// Module Name: fsm_decoder
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


module fsm_decoder(
    input enable,clk,
    output reg [5:0] adress_buffer,
    output reg [5:0]addr_read,
    output reg [5:0] addr_64
    );
    
  parameter zigzag_quantization=3'b000,
            idct_1=3'b001,
            idct_2=3'b010,
            rgb=3'b011,
            hdmi=3'b100;
 reg [5:0] count_idct=6'd0; 
 reg [5:0] count_zigzag=6'd0; 
 assign count_zigzag_finish =(count_zigzag==64)? 1'b1: 1'b0;
 
 reg [2:0]add_8=3'b000;
  reg [2:0]add_64=3'b000;
  assign count_idct_finish =(count_idct==64)? 1'b1: 1'b0;
   
reg[5:0]zigzag[0:63]    ; //zigzag
  initial $readmemh("zigzag.txt", zigzag);
  reg [2:0] state;
always @(posedge clk)
begin
	
    
    if(enable)
    begin   
        state <= zigzag_quantization;
        
    end
    else
    begin
    
        case(state)
    
          zigzag_quantization: begin
          						if(count_zigzag_finish)
                                    begin
                                        count_zigzag<=6'd0;
                                        state <= idct_1;
                                     end
                                adress_buffer <=zigzag[count_zigzag];
                                count_zigzag <=count_zigzag+1;
          
                               end
                               
        idct_1: begin
                          		if(count_idct_finish)
                                    begin
                                        count_idct<=6'd0;
                                        state <= idct_2;
                                     end
                              else
                              begin
                                    
                                   if (add_8<8)
                                       begin
                                           addr_read <=add_8;
                                           addr_64 <=count_idct;
                                           add_8<=add_8+1;
                                             
                                            count_idct<=count_idct+1;
                                       end
                                   else
                                       add_8<=6'd0; 
                                    
                              end     
                         
                    end
        endcase
    end  
     end        
endmodule
