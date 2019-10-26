----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2019 11:03:34
-- Design Name: 
-- Module Name: full_adder_tb - Behavioral
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

entity full_adder_tb is
--  Port ( );
end full_adder_tb;

architecture Behavioral of full_adder_tb is
 signal a1 : std_logic :='0';
 signal b1 : std_logic :='0';
 signal cin1 : std_logic :='0';
 signal sum1:std_logic;
 signal carry1:std_logic;
 
begin
  uut : entity work.full_adder 
     port map(
     a => a1,
     b => b1,
     cin=>cin1,
     sum=>sum1,
     carryout =>carry1);
    process is 
    begin
     a1<='0';
     b1<='0';
     cin1<='0';
     wait for 10 ns;
     
     a1<='0';
     b1<='0';
     cin1<='1';
     wait for 10 ns;
     
     a1<='0';
     b1<='1';
     cin1<='0';
     wait for 10 ns;
     
     a1<='0';
     b1<='1';
     cin1<='1';
     wait for 10 ns;
     
     a1<='1';
     b1<='0';
     cin1<='0';
     wait for 10 ns;
     
     a1<='1';
     b1<='0';
     cin1<='1';
     wait for 10 ns;
     
     a1<='1';
     b1<='1';
     cin1<='0';
     wait for 10 ns;
     
     a1<='1';
     b1<='1';
     cin1<='1';
     wait for 10 ns;
    end process;      
     
     
    
end Behavioral;
