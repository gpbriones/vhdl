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

entity MUX_2X1 is
     generic(
     n:integer :=32
    );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           sel : in STD_LOGIC;
           z : out STD_LOGIC_VECTOR (n-1 downto 0));
end MUX_2X1;

architecture Behavioral of MUX_2X1 is

begin
    process (sel,a,b)
    begin
        case sel is
        when '0' => z <= a;
        when '1' => z <= b;
        when others => z <= (others=>'0');
        end case;
end process;

end Behavioral;
