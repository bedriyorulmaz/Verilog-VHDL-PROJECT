
 module top  (   
                 input wire clk_125mhz,                  //100mhz global system clock
                 input wire vs,hs,               //sync signals
                 input wire pclk,                //pixel clock output
	 		     input wire [7:0] D,              //Data Lines from module
                            //12mhz clock in
		 		 output wire xclk,               //12mhz clock input to module
//		 		 output wire out_uart,            //Uart out to PC
                 input wire start_cam,           //switch to initialize camera with reg values
				 input wire switch_pic,          //switch input to capture image
                 output wire sda,scl,             //i2c signals
                output wire quantize_out
             );


  
 wire enable_decoder;
 wire clk;
 wire [15:0] w_addr,r_addr;
 wire [7:0] outbuff;
  wire [7:0] outbuff_dct,dctout_data;
 wire [7:0] udata;
 wire [7:0] second_dct_data,quantizer_in;
 wire [7:0] first_dct_out_data;
  wire [7:0] second_dct_out_data;
 wire [4:0] addr_rom;
 wire [15:0] data_rom;
 wire clk_12mhz;
 wire [2:0] add_8_dct_1;
 wire [5:0] add_64_dct_1;
  wire [2:0] add_8_dct_2;
 wire [5:0] add_64_dct_2;
 wire [5:0] ram_dct_address,r_addr_ramdct,dctout_addr,quantizer_add_in;
  wire [5:0] ram_dct_address_dctout;
 wire wea_ram,wea_ram_dctout,start_dct_second_s;
 wire we;
 assign xclk = clk_12mhz;	
 

 
 clk_wiz_1 u3 (.clk_out1(clk),.clk_out2(clk_12mhz), .clk_in1(clk_125mhz));
 FSM fsm( .clk(clk),
          .take_pic(!switch_pic),
          .frame_complete(frame_cap),
	       
	         
          .load_buffer(load),
          .start_uart(u_s),
          .uart_reset(ur),
	      .start_dct_second(start_dct_second_s),
           
          //.second_dct_in_data(second_dct_data),
          .buff_read_addr(r_addr),
          .load_rom(load_config_rom),
		  .done_rom(done_config_rom),
          .start_cam(start_cam),
          .add_8(add_8_dct_1),
          .add_64(add_64_dct_1),
           .add_8_dct(add_8_dct_2),
          .add_64_dct(add_64_dct_2),
          .read_addr_ramdct(r_addr_ramdct),
          .dct_out_add(dctout_addr),
           
          
         // .quantizer_indata(quantizer_in ),
          .quantizer_add(quantizer_add_in)
	    );

 
 i2c_core i2c( .clk(clk),
               .i2c_reset(load_config_rom),
    		   .val_addr(addr_rom),
               .i2c_in_data(data_rom),
               .sda(sda),
               .scl(scl),
			   .i2c_start_tx(done_config_rom)
             );

 
 ov7670_regs rom( .clk(clk),
                  .addr(addr_rom),
                  .b(data_rom)
                );




 
// uart_tx u_tx( .clk(clk),
//              .in_data(udata),
//              .start_tx(u_s),
//			  .reset(ur),
//              .out_tx(out_uart),
//              .byte_sent(next)
            
//             );

 
 frame_capture capture( .clk(clk),
                        .HS(hs),
                        .VS(vs),
                        .addr(w_addr),
			            .start_capture(load),
                        .pclk(pclk),
                        .write_to_buff(we),
                        .frame_captured(frame_cap)

                      );

 //Xilinx Core Generator Block Ram 
 R_1 ram( .clka(clk),         // input clka
                .wea(we),           // input [0 : 0] wea
                .addra(w_addr),     // input [15 : 0] addra
                .dina(D),           // input [7 : 0] dina
                .clkb(clk),         // input clkb
                .addrb(r_addr),     // input [15 : 0] addrb
                .doutb(outbuff)     // output [7 : 0] doutb
             );

    dct dct_first(
	.clk(clk),			                                   //	input clock
	.reset(ur),		  	                                   //	reset
	.wr(u_s),		                                           //	writing data to memory
	.oe(u_s),		                                           //	displaying the final output
	 .data_in(outbuff),	                                           //	8-bit data input
	 .add(add_8_dct_1),		                                           //	3-bit address for data input
	 .data_out(first_dct_out_data) ,
	 .add_64(add_64_dct_1)  ,
	 .ram_dct_add(ram_dct_address) ,
	 .wea(wea_ram)                                       //	8-bit data output
	);	
	
	
	dct_ram_1 dct_ram
   (.clka(clk),
    .wea(wea_ram),
    .addra(ram_dct_address),
    .dina(first_dct_out_data),
    .clkb(clk),
    .addrb(r_addr_ramdct),
    .doutb(outbuff_dct));


    dct dct_second(
	.clk(clk),			                                   //	input clock
	.reset(ur),		  	                                   //	reset
	.wr(start_dct_second_s),		                                           //	writing data to memory
	.oe(start_dct_second_s),		                                           //	displaying the final output
	 .data_in(outbuff_dct ),	                                           //	8-bit data input
	 .add(add_8_dct_2),		                                           //	3-bit address for data input
	 .data_out(second_dct_out_data) ,
	 .add_64(add_64_dct_2)  ,
	 .ram_dct_add(ram_dct_address_dctout) ,
	 .wea(wea_ram_dct)                                       //	8-bit data output
	);
	
	
	dct_out_1 dct_out_ram(
	
	.clka(clk),
	.wea(wea_ram_dct),
	.addra(ram_dct_address_dctout),
	.dina(second_dct_out_data),
	.clkb(clk),
	.addrb(dctout_addr),
	.doutb(dctout_data)
	      );
	      
	quantizer qua (
	.clk(clk),
	.data(dctout_data),
	.data_add(quantizer_add_in),
	.d_out(quantize_out),
	.enable(enable_decoder)
	) ;     
	 
	      
	      
	
endmodule
