module idct(
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


 


assign y_0=a*x[0] + c*x[2] + a*x[4] + f*x[6] + b*x[1] + d*x[3] + e*x[5] + g*x[7] ;

assign y_1=a*x[0] + f*x[2] - a*x[4] - c*x[6] + d*x[1] - g*x[3] - b*x[5] - e*x[7] ;

assign y_2=a*x[0] - f*x[2] - a*x[4] + c*x[6] + e*x[1] - b*x[3] + g*x[5] + d*x[7] ;

assign y_3=a*x[0] - c*x[2] + a*x[4] - f*x[6] + g*x[1] - e*x[3] + d*x[5] - b*x[7] ;


assign y_4=a*x[0] + c*x[2] + a*x[4] + f*x[6] - b*x[1] + d*x[3] + e*x[5] + g*x[7] ;

assign y_5= a*x[0] + f*x[2] - a*x[4] - c*x[6] - d*x[1] - g*x[3] - b*x[5] - e*x[7] ;

assign y_6 =a*x[0] - f*x[2] - a*x[4] + c*x[6] - e*x[1] - b*x[3] + g*x[5] + d*x[7] ;

assign y_7 =a*x[0] - c*x[2] + a*x[4] - f*x[6] - g*x[1] - e*x[3] + d*x[5] - b*x[7] ;

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

 