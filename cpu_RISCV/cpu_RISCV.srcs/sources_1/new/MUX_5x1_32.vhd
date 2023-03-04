----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2023 18:03:13
-- Design Name: 
-- Module Name: MUX_32X1 - Behavioral
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

entity MUX_5X1_32 is
     generic(
     n:integer :=32
    );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           c : in STD_LOGIC_VECTOR (n-1 downto 0);
           d : in STD_LOGIC_VECTOR (n-1 downto 0);
           e : in STD_LOGIC_VECTOR (n-1 downto 0);
           f : in STD_LOGIC_VECTOR (n-1 downto 0);
           sel : in STD_LOGIC_VECTOR (2 downto 0);
           z : out STD_LOGIC_VECTOR (n-1 downto 0));
end MUX_5X1_32;

architecture Behavioral of MUX_5X1_32 is

begin
--actualizar desde este archivo para ver cambios 
    process (sel,a,b,c,d,e,f)
    begin
        case sel is
        when "000" => z <= a;
        when "001" => z <= b;
        when "010" => z <= c;
        when "011" => z <= d;
        when "100" => z <= e;
        when "101" => z <= f;
        when others => z <= (others=>'0');
        end case;
end process;

end Behavioral;
