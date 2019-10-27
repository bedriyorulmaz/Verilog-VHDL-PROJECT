----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.10.2019 12:08:02
-- Design Name: 
-- Module Name: carry_adder - Behavioral
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

entity carry_adder is
  Port (A: in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        Si: out std_logic_vector(3 downto 0);
        cin : in std_logic;
        cout: out std_logic
          );
end carry_adder;

architecture Behavioral of carry_adder is
component par_full_adder is 
    Port (
        A: in STD_LOGIC;
        B: in STD_LOGIC;
        cin: in STD_LOGIC;
        Pi:out STD_LOGIC;
        Gi:out STD_LOGIC;
        Si:out STD_LOGIC );
       
end component;
signal c1,c2,c3: STD_LOGIC;
signal Pi,Gi : STD_LOGIC_VECTOR(3 downto 0);

begin
u : par_full_adder port map(A(0),B(0),cin,Pi(0),Gi(0),Si(0));
u1 : par_full_adder port map(A(1),B(1),c1,Pi(1),Gi(1),Si(1));
u2: par_full_adder port map(A(2),B(2),c2,Pi(2),Gi(2),Si(2));
u3 : par_full_adder port map(A(3),B(3),c3,Pi(3),Gi(3),Si(3));

c1<=Gi(0) or (Pi(0) and cin);
c2<=Gi(1) or (Pi(1) and Gi(0)) or (Pi(1) and Pi(0) and cin); 
c3<=Gi(2) or (Pi(2) and Gi(1)) or (Pi(2) and Pi(1) and Gi(0)) or (Pi(2) and Pi(1) and Pi(0) and cin);
cout<= Gi(3) or (Pi(3) and Gi(2)) or (Pi(3) and Pi(2) and Pi(1) and Gi(0)) or (Pi(3) and Pi(2) and Pi(1) and Pi(0) and cin);

end Behavioral;
