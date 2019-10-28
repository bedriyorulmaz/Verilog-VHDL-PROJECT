----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 07:26:45
-- Design Name: 
-- Module Name: parallel_adder - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity parallel_adder is
  Port (
        A :in std_logic_vector(3 downto 0);
        B :in std_logic_vector(3 downto 0);
        cin:in std_logic;
        S  :out std_logic_vector(3 downto 0);
        cout :out std_logic     
            );
end parallel_adder;

architecture Behavioral of parallel_adder is

begin
process(A,B,cin)
variable u:std_logic;
begin
u := cin;
for i in 0 to 3 loop
S(i)<= A(i) xor B(i) xor u;
u:= (A(i) and B(i)) or (A(i) and u) or (u and B(i));
end loop;
cout<=u;
end process; 

end Behavioral;
