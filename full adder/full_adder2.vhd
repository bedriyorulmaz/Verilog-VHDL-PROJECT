----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.10.2019 23:29:00
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
  Port (a:in std_logic;
        b:in std_logic;
        cin:in std_logic;
        sum:out std_logic;
        carryout:out std_logic );
end full_adder;

architecture Behavioral of full_adder is

signal temp1,temp2,temp3: std_logic;
begin
temp1<= a xor b;
temp2<= a and b;
sum<= temp1 xor cin;
temp3<= cin and temp1;
carryout <= temp3 or temp2;

end Behavioral;
