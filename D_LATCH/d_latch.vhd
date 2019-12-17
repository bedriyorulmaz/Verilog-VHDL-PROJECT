----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2019 14:55:38
-- Design Name: 
-- Module Name: d_latch - Behavioral
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

entity d_latch is
    Port ( in_en : in STD_LOGIC;
           in_giris : in STD_LOGIC;
           out_cikis : out STD_LOGIC;
           out_cikis_degil : out STD_LOGIC);
end d_latch;

architecture Behavioral of d_latch is
    signal r_cikis: std_logic:='0';
begin
    process(in_en,in_giris)
    begin
        if in_en= '1' then
            r_cikis <= in_giris;
        end if;
    end process;
    
    out_cikis<=r_cikis;
    out_cikis_degil <=(not r_cikis);
        
    

end Behavioral;
