----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Design Name: 
-- Module Name: spi - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi is
    Port ( 
             clk  : in STD_LOGIC;
             enable : in STD_LOGIC;
             dataIn : in STD_LOGIC_vector(15 downto 0);
             SCL : out STD_LOGIC;
             SDA : out STD_LOGIC
     );     
end spi;

architecture Behavioral of spi is

signal state       : std_logic_vector(3 downto 0) := "0000"; 

--signal clkS        : std_logic;
--signal clk_counter : std_logic := '0';
signal counter     : std_logic_vector(3 downto 0) := "0000";
signal index       : integer := 0;
signal data        : std_logic := '0';
signal sck         : std_logic := '1';

begin

SDA <= data;
SCL <= sck;



process(clk)
begin
if rising_edge(clk) then  --write
    CASE state is
    
    WHEN "0000" => 
        if (enable = '1') then
            counter <= counter + 1;
            if (counter = 0) then
                data <= dataIn(7 - index);
            elsif (counter = 3) then
                sck <= '1';
            elsif (counter = 9) then
                sck <= '0'; 
            elsif (counter = 11) then
                data <= '0'; 
            elsif (counter = 12) then
                counter <= "0000";
                state <= "0001";   
            end if;
        end if;
     WHEN "0001" =>
        if (index < 7) then
            index <= index + 1;
        elsif (index = 7) then
            state <= "0010";
            counter <= "0000";
        end if;
        if (index < 7) then
            state <= "0000";
        end if;    
         
     WHEN "0010" =>
        index <= 0;
        counter <= "0000";
        state <= "0000";           
     WHEN others =>
         state <= "0000";
end case;
end if;
end process;

end Behavioral;