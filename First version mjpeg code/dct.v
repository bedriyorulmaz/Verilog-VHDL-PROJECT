module dct(
	input clk,			                                   //	input clock
	input reset,		  	                                   //	reset
	input wr,	
	input [6:0] add_64,	                                           //	writing data to memory
	input oe,		                                           //	displaying the final output
	input [7:0]data_in,	                                           //	8-bit data input
	input [2:0]add,		                                           //	3-bit address for data input
	output reg [7:0]data_out,
	output reg [6:0]ram_dct_add ,
	output reg wea                                          //	8-bit data output
	);	                                        

wire [31:0]y_0,y_1,y_2,y_3,y_4,y_5,y_6,y_7;
wire [15:0]y0,y1,y2,y3,y4,y5,y6,y7;
wire [8:0] t0_7,t1_6,t2_5,t3_4,c0_7,c1_6,c2_5,c3_4;
reg [7:0]x[7:0];	                                    //	8-bit 8 locations data storage after reading
parameter a=16'h5a82;
parameter b=16'h7d8a;
parameter c=16'h7642;
parameter d=16'h6a6e;
parameter e=16'h471d;
parameter f=16'h30fc;
parameter g=16'h18f9;

/****************************WRITING DATA TO MEMORY***********************/
always @( posedge clk) 
begin
if(reset)
x[add]=0;
else if(wr)
x[add]= data_in;
end


sum_diff b1(t0_7,c0_7,x[0],x[7],1);
sum_diff b2(t1_6,c1_6,x[1],x[6],1);
sum_diff b3(t2_5,c2_5,x[2],x[5],1);
sum_diff b4(t3_4,c3_4,x[3],x[4],1);


assign y_0=a*(t0_7+t1_6+t2_5+t3_4);

assign y_1=b*c0_7+d*c1_6+e*c2_5+g*c3_4;

assign y_2=c*(t0_7-t3_4) + f*(t1_6-t2_5);

assign y_3=d*c0_7 - g*c1_6 - b*c2_5 - e*c3_4;

assign y_4=a*(t0_7 + t3_4 - t1_6 - t2_5);

assign y_5= e*c0_7 - b*c1_6 + g*c2_5 + d*c3_4;

assign y_6 = f*(t0_7 - t3_4) + c*(t2_5 - t1_6) ;

assign y_7 = g*c0_7 - e*c1_6 + d*c2_5 - b*c3_4;

assign y0=y_0>>16;

assign y1=y_1>>16;

assign y2=y_2>>16;

assign y3=y_3>>16;

assign y4=y_4>>16;

assign y5=y_5>>16;

assign y6=y_6>>16;

assign y7=y_7>>16;



/**************DISPLAY THE FINAL OUTPUT ACC. TO ADDRESS GIVEN*************/
always @(add)
begin
if(oe)
case(add)
	3'b000: begin  data_out=y0; ram_dct_add <=add_64; wea <= 1'b1;
	        end   
	3'b001:begin data_out=y1;ram_dct_add <=add_64;wea <= 1'b1;
	end
	3'b010: begin data_out=y2;ram_dct_add <=add_64;wea <= 1'b1;
	end
	3'b011:begin data_out=y3;ram_dct_add <=add_64;wea <= 1'b1;
	end
	3'b100:begin data_out=y4;ram_dct_add <=add_64;wea <= 1'b1;
	end
	3'b101: begin data_out=y5;ram_dct_add <=add_64;wea <= 1'b1;
	end
	3'b110: begin data_out=y6;ram_dct_add <=add_64;wea <= 1'b1;
	end
	3'b111: begin data_out=y7;ram_dct_add <=add_64;wea <= 1'b1;
	end
	default: data_out=0;
endcase
else
data_out=0;
end
endmodule

module signed_mult(
  input [7:0]a,                         // Multiplicend 1
  input [7:0]b,                         // Multiplicend 2
  output reg [15:0]y                    // Result
  );
  
  reg [15:0]temp;
  reg [7:0]p;
  reg [7:0]q;
  reg m;
 
  always@(a or b)
  begin
  case({a[7],b[7]})
  2'b00:begin
		  y=a*b;
		  y=y>>6;
		  end  
		  
  2'b01:begin
        q=(~b)+1;
		  temp=a*q;
		  y=(~temp)+1;
		  end
		  
  2'b10:begin
        p=(~a)+1;
		  temp=p*b;
		  temp=temp>>6;
		  y=(~temp)+1;
		  end
		  
  2'b11:begin
        q=(~b)+1;
		  p=(~a)+1;
		  temp=p*q;
		  y=temp;
		  end	  
   default:begin
		  y=a*b;
		  end  
  
  endcase
  end


endmodule
module sum_diff(
    output reg [31:0] sum,diff,                                           // 32-bit output registers to store sum and difference
    input [31:0] x,y,                                                     // 32-bit input nets x and y
    input en                                                              // To enable the operation of butterfly
    );

always @(en or x or y)
begin
  sum=x+y;
  diff=x-y;
end
endmodule