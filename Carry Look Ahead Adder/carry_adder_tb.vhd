----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2019 12:35:36
-- Design Name: 
-- Module Name: carry_adder_tb - Behavioral
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

entity carry_adder_tb is
--  Port ( );
end carry_adder_tb;

architecture Behavioral of carry_adder_tb is
component carry_adder
    Port (A: in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        Si: out std_logic_vector(3 downto 0);
        cin : in std_logic;
        cout: out std_logic
          );
end component;
signal a1 : std_logic_vector(3 downto 0) := (others => '0') ;
signal b1 : std_logic_vector(3 downto 0) := (others => '0') ;
signal cin: std_logic :='0';
signal sum1 : std_logic_vector(3 downto 0);
signal carry : std_logic;


begin
    uut : carry_adder port map(
    A=> a1,
    B => b1,
    Si => sum1,
    cin => cin,
    cout => carry
    );
    stim_proc: process 
    begin
    wait for 10 ns;
    a1<="1111";
    b1<="1111";
    cin<='1';
    wait for 10 ns;
    
    a1<="1010";
    b1<="0111";
    cin<='0';
    wait for 10 ns;
    
    a1<="1000";
    b1<="1001";
    cin<='0';
    wait for 10 ns;
  end process;    
end Behavioral;
