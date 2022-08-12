
module alu(a, b, aluctrl,  aluOut, zero, LSb_aluresult);
   input  [31:0] a, b;
   input  [3:0] aluctrl;
   output[31:0] aluOut;
   output zero, LSb_aluresult;
   reg[31:0] aluOut;
   assign zero = (aluOut==0) ? 1 : 0;
   assign LSb_aluresult = aluOut[0];
   always @(aluctrl or a or b)
      casex (aluctrl)
         0: aluOut <= a & b;
         1: aluOut <= a | b;
         2: aluOut <= OUT(a, b);
         4: aluOut <= a ^ b; //xor
         5: aluOut <= a / b;
         10: aluOut <= a - b;
         11: aluOut <= (a < b) ? 1:0;
         12:aluOut <= compare(a,b)? 1:0;
         13:aluOut <= a<<b;
         14:aluOut <= a>>b;
         15:aluOut <= a>>>b;
         
         default: aluOut<=0;
      endcase

      /* Function to signed operation*/
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
      
      function [31:0] compare;
          input [31:0] a, b;
          begin
          casex(b[31])
              1'b1:   begin
                      if(a[31])
                        compare=b<a;
                      else
                        compare=0;  
                      end
               1'b0 : begin
                      if(a[31])
                        compare=1;
                      else
                        compare=a<b;  
                      end     
              default: compare = a <b;
          endcase
          end
      endfunction
endmodule