----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2020 14:14:28
-- Design Name: 
-- Module Name: sim_top - Behavioral
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

entity sim_top is
--  Port ( );
end sim_top;

architecture Behavioral of sim_top is
component top is
 Port (      clk: in STD_LOGIC;
                in_port: in STD_LOGIC_VECTOR( 7 DOWNTO 0);
                port_id:out STD_LOGIC_VECTOR(7 DOWNTO 0);
                out_port : out STD_LOGIC_VECTOR (7 downto 0));
    end component top;
    
signal clk: STD_LOGIC;
signal in_port : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal port_id : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal out_port : STD_LOGIC_VECTOR(7 DOWNTO 0);
    
begin

uut: top port map(
        clk=>clk,
        in_port=>in_port,
        port_id=>port_id,
        out_port=>out_port
        
        
        
);
process
begin
    clk<= '0';
    wait for 5ns;
    clk<='1';
    wait for 5ns;
end process;
    
end Behavioral;
