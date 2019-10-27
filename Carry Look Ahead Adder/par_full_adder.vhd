----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.10.2019 17:18:42
-- Design Name: 
-- Module Name: par_full_adder - Behavioral
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

entity par_full_adder is
  Port (
      A: in STD_LOGIC ;
      B:in STD_LOGIC;
      cin:in STD_LOGIC;
      Pi:out STD_LOGIC;
      Gi:out STD_LOGIC;
      Si:out STD_LOGIC    );
end par_full_adder;

architecture Behavioral of par_full_adder is

begin
Pi<= A xor B ;
Gi<= A AND B;
Si<= A xor B xor cin; 

end Behavioral;
