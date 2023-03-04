----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2023 10:42:42
-- Design Name: 
-- Module Name: UA - Behavioral
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

entity UA is
    generic(
      n:integer :=32
  );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           s : in STD_LOGIC_VECTOR (1 downto 0);
           c_in : in STD_LOGIC;
           za : out STD_LOGIC_VECTOR (n-1 downto 0);
           c_out : out STD_LOGIC);
end UA;

architecture Behavioral of UA is
    signal al_compl2 : STD_LOGIC_VECTOR (n-1 downto 0) ;
    signal al_za_sum : STD_LOGIC_VECTOR (n downto 0) ;
    signal al_za_sus : STD_LOGIC_VECTOR (n downto 0);
    signal al_compl_2 : STD_LOGIC_VECTOR (n downto 0);
    signal al_za_mul : STD_LOGIC_VECTOR (2*(n)-1 downto 0);
    
begin
    al_za_sum <= ('0'&a) + ('0'&b);
    al_compl2 <= not(b) + x"00000001";
    al_compl_2 <= ('0'&not(b)) + ('0'&x"00000001");
    al_za_sus <=  ('0'&a) + (al_compl_2);
    
    process(s,al_za_sum)
    begin
    case s is
            when "00" =>
                --za <= a+b;
                -- al_za_sum <= ('0'&a) + ('0'&b);
                 za <= al_za_sum(n-1 downto 0);
                 c_out <= al_za_sum(n);
            when "01" =>
                za <= a+al_compl2;
                
--                za <= al_za_sus(n-1 downto 0);
                c_out <= al_za_sus(n);
            when "10" =>
                al_za_mul <= a*b;
                za <= al_za_mul(n-1 downto 0);
            when "11" =>
                  za <= a+b;
            when others => -- 'U', 'X', '-', etc.
                za <= (others => '0');
        end case;
     end process;  
end Behavioral;
