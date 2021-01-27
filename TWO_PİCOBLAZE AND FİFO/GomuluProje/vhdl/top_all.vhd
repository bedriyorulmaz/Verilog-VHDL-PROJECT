----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2021 16:12:50
-- Design Name: 
-- Module Name: top_all - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_all is
  Port ( clk: in STD_LOGIC;
               
                
                out_port_all : out STD_LOGIC_VECTOR (7 downto 0));
end top_all;

architecture Behavioral of top_all is

component top is
      Port ( clk : in STD_LOGIC;
           in_port : in STD_LOGIC_VECTOR (7 downto 0);
           
           port_id : out STD_LOGIC_VECTOR (7 downto 0);
           out_port : out STD_LOGIC_VECTOR (7 downto 0);
           
           write_strobe : out STD_LOGIC);  
end component top;

component top_2 is
      Port ( clk : in STD_LOGIC;
           in_port : in STD_LOGIC_VECTOR (7 downto 0);
           interrupt : in STD_LOGIC;
           port_id : out STD_LOGIC_VECTOR (7 downto 0);
           out_port : out STD_LOGIC_VECTOR (7 downto 0);
           read_strobe : out STD_LOGIC
           );  
end component top_2;

COMPONENT fifo_generator_0
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    almost_full : OUT STD_LOGIC;
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    data_count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    
  );
END COMPONENT;
signal write_strobe :  STD_LOGIC;

signal port_id : std_logic_vector (7 downto 0);
signal out_port_pico1 :  std_logic_vector (7 downto 0);

signal read_strobe_2 :  STD_LOGIC;
signal port_id_2 : std_logic_vector (7 downto 0);
signal data_count :std_logic_vector( 3 downto 0);

signal interrupt_full :  STD_LOGIC;
signal pico_2_input :std_logic_vector (7 downto 0);
begin
pico: top
 port map(
             clk => clk,
             in_port(7 downto 4)=>"0000",
             in_port(3 DOWNTO 0) => data_count,
             out_port => out_port_pico1,
             port_id => port_id,
             
             write_strobe => write_strobe
             
 );

pico_2: top_2
 port map(
             clk => clk,
             in_port => pico_2_input ,
             out_port => out_port_all,
             port_id => port_id_2,
             read_strobe => read_strobe_2,
           
             interrupt =>interrupt_full
 );
 
your_instance_name : fifo_generator_0
  PORT MAP (
    clk => clk,
    srst => '0',
    din => out_port_pico1 ,
    wr_en => write_strobe,
    rd_en => read_strobe_2,
    dout => pico_2_input,
    
    almost_full => interrupt_full,
    data_count => data_count
    
  );
end Behavioral;
