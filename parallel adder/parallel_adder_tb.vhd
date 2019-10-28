----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 07:46:39
-- Design Name: 
-- Module Name: parallel_adder_tb - Behavioral
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

entity parallel_adder_tb is
--  Port 
end parallel_adder_tb;

architecture Behavioral of parallel_adder_tb is
component parallel_adder
    Port (a : in std_logic_vector (3 downto 0);
            b : in std_logic_vector (3 downto 0);
            cin:in std_logic;
            S : out std_logic_vector (3 downto 0);
            cout : out std_logic
              );
end component;
signal a: std_logic_vector (3 downto 0) := (others => '0');
signal b: std_logic_vector (3 downto 0 ) := (others => '0');
signal cin:std_logic := '0' ;
signal sum:std_logic_vector (3 downto 0);
signal carryout :std_logic;  
      
begin
uut: parallel_adder port map(
A => a ,
B => b , 
cin => cin ,
S => sum ,
cout => carryout);
stim_proc: process
begin
wait for 100 ns;
a <= "0110";
b <= "1100";
     
wait for 100 ns;
a <= "1111";
b <= "1100";
     
wait for 100 ns;
a <= "0110";
b <= "0111";
     
wait for 100 ns;
a <= "0110";
b <= "1110";
     
wait for 100 ns;
a <= "1111";
b <= "1111";
wait;
end process;



end ;