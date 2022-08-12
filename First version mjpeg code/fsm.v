


module FSM(		    input wire clk,start_cam,
					input wire take_pic,frame_complete,
					 
					 
					output reg load_buffer,start_uart,start_dct_second,
					
					//output reg [7:0] uart_in_data,//
					//output reg [7:0] second_dct_in_data,//
					output reg uart_reset,
					output reg [15:0] buff_read_addr,
					
					output reg [2:0] state,
					input wire done_rom,
					output reg load_rom,
					output  reg [2:0] add_8,
					output reg [5:0] add_64,
					output  reg [2:0] add_8_dct,
					output reg [5:0] add_64_dct,
					output reg [5:0] read_addr_ramdct,
				     output reg [5:0] dct_out_add ,
                     
          
                   // output reg [7:0]quantizer_indata  ,
                     output reg  [5:0]quantizer_add 

		  	);


reg [5:0]read_ram_dct;
reg [5:0]read_ram_zigzag;
parameter BUTTON = 3'b000,
		  BUFFER = 3'b001,
			DCT = 3'b010,
			ROM = 3'b011,
			DCT_SECOND=3'b100,
			ZIGZAG_QUANTIZER=3'b101;
reg [15:0] buff_read_addr_count;
assign read_buff_complete = (buff_read_addr_count == 38401) ? 1'b1: 1'b0;
assign read_buff_complete_dct =(read_ram_dct==65)? 1'b1: 1'b0;
assign read_buff_complete_zigzag =(read_ram_zigzag==65)? 1'b1: 1'b0;
reg [2:0]count_8=3'b000;
reg [2:0] count_a=3'b000;
reg [5:0]count_64=6'd0;
reg [5:0] count_zigzag=6'd0;
reg [2:0]count_8_dct=3'd0;
reg [5:0]count_64_dct=6'd0;

reg[5:0]zigzag[0:63]    ; //zigzag
  initial $readmemh("zigzag.txt", zigzag);
always @(posedge clk)
begin
	uart_reset <= 1'b0;
    
    if(start_cam)
    begin   
        state <= ROM;
        load_rom <= 1'b1;
    end

    else
	begin
	case(state)

		ROM:	begin
					load_rom <= 1'b0;
					if(done_rom)
					begin
						
						state <= BUTTON;
					end
				end

		BUTTON:	begin
						if(take_pic)
						begin
							uart_reset <= 1'b1;
							buff_read_addr <= 16'd1;
							state <= BUFFER;
						end
					end

		BUFFER:	begin
						if(frame_complete)
						begin
							load_buffer <= 1'b0;
							state <= DCT;
						end
						else
							load_buffer <= 1'b1;
					end


		DCT:		begin
						start_uart <= 1'b1;
						if(read_buff_complete)
						begin
							start_uart <= 1'b0;
							state <= BUTTON;	
						end
						else		
						begin
						    if (count_64<64)
						    begin
                                if (count_8<8)
                                begin
                                     
                                    add_8 <= count_8; //for dct ram
                                    add_64 <= count_64 ;//for send dct to dct arm
                                    
                                    buff_read_addr <= buff_read_addr + 1'b1;
                                    count_8 <=count_8+1;
                                    	
                                    count_64 <=count_64+1;
                                    
                                    
                                end							
							    else
                                begin
                                     count_8<=0;
                                     buff_read_addr <= buff_read_addr+153;
                                     
                                     
                                end
								buff_read_addr_count <= buff_read_addr_count + 1'b1;
								
						    end
						   else 
						      begin
						          state <= DCT_SECOND;
						          read_ram_dct <=6'd1;
						      end
	       				    
						    		
						end

					end
        DCT_SECOND:	begin
                        start_dct_second <= 1'b1;
						if(read_buff_complete_dct)
						begin
                            start_dct_second <= 1'b0;
                            state <= ZIGZAG_QUANTIZER;	
                        end
            
                            if(read_ram_dct <=64)
                            begin
                                if(count_8_dct<8)
                                    begin
                                      
                                    read_addr_ramdct <=read_ram_dct;
                                    read_ram_dct<=read_ram_dct+8;
                                    
                                    
                                    add_8_dct <= count_8_dct;
                                    add_64_dct <= count_64_dct ;
                                    
                                    
                                    count_8_dct <=count_8_dct+1;
                                    	
                                    count_64_dct <=count_64_dct+1;
                                    
                                    end
                                else
                                    begin
                                    count_8_dct<=0;
                                    read_ram_dct <=read_ram_dct -52;
                                    end
        
                            
                            
                        end
                        else 
                        begin
                            read_ram_dct<=6'd0;
                            state <=ZIGZAG_QUANTIZER;
                        
                        end
                        
                    
                       end
                    
      
      
      ZIGZAG_QUANTIZER :begin
                            
                        if(read_buff_complete_zigzag)
						begin
                            
                            state <= ZIGZAG_QUANTIZER;	
                        end
                           
                           dct_out_add<= zigzag[count_zigzag];
                           quantizer_add <=zigzag[count_zigzag];
                           count_zigzag<=count_zigzag+1;
                           
                                    
      
            end
      
                    
                    
	endcase
	end
end

							


endmodule

