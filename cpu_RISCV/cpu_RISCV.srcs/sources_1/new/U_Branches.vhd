----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2023 10:42:42
-- Design Name: 
-- Module Name: U_Branches - Behavioral
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
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity U_Branches is
    generic(
      n:integer :=32
  );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           s : in STD_LOGIC_VECTOR (2 downto 0);
           zUB : out STD_LOGIC_VECTOR (n-1 downto 0)
           );
end U_Branches;

architecture Behavioral of U_Branches is
    
begin
    process(s,a,b)
    begin
    case s is
        when "000" => --hacia selector de mux de salto: caso:a = b
            if a=b then
                zUB <= x"00000001";   --a=b
            else
                zUB <= x"00000000";
            end if;
        when "001" =>
            if a<b then            --a<b
                zUB <= x"00000001"; 
            else
                zUB <= x"00000000";
            end if;
        when "100" =>
            if a>b then              ---a>b
                 zUB <= x"00000001"; 
            else
                zUB <= x"00000000";
            end if; 
        when "101" =>
            zUB <= x"00000003"; --pendientes, poner 1
       when "110" =>
            zUB <= x"00000004"; --pendiente 
       when "111" =>
            zUB <= x"00000005";  --pendiente
      when others => -- 'U', 'X', '-', etc.
           zUB <= (others => '0');
        end case;
     end process;  
end Behavioral;
