----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2019 14:23:43
-- Design Name: 
-- Module Name: ripple_carry_adder - Behavioral
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

entity ripple_carry_adder is
  Port ( 
        a : in std_logic_vector (3 downto 0);
        b : in std_logic_vector (3 downto 0);
        cin: in std_logic;
        sum : out std_logic_vector (3 downto 0);
        carryout : out std_logic
          );
end ripple_carry_adder;

architecture Behavioral of ripple_carry_adder is


component full_adder is
    Port (
        a:in std_logic;
        b:in std_logic;
        cin:in std_logic;
        sum:out std_logic;
        carryout:out std_logic ); 
end component;        
signal c1,c2,c3 : std_logic;        
               
begin
u :  full_adder port map(a(0) , b(0) , cin , sum(0) , c1 );
u1 : full_adder port map(a(1) ,  b(1) , c1 , sum(1) , c2);
u2 : full_adder port map(a(2) , b(2) , c2 , sum(2) , c3);
u3 : full_adder port map(a(3) , b(3) , c3 , sum(3) , carryout);


end Behavioral;
