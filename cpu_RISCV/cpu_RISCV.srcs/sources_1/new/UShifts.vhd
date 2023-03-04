----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2023 10:42:42
-- Design Name: 
-- Module Name: UShifts - Behavioral
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

entity UShifts is
    generic(
      n:integer :=32
  );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           s : in STD_LOGIC_VECTOR (2 downto 0);
           zUS : out STD_LOGIC_VECTOR (n-1 downto 0)
           );
end UShifts;

architecture Behavioral of UShifts is
    signal al_zus_sll : STD_LOGIC_VECTOR (n-1 downto 0) ;
    signal al_zus_slli: STD_LOGIC_VECTOR (n-1 downto 0) ;
    signal al_zus_srl : STD_LOGIC_VECTOR (n-1 downto 0) ;
    signal al_zus_srli: STD_LOGIC_VECTOR (n-1 downto 0) ;
    signal al_zus_sra : STD_LOGIC_VECTOR (n-1 downto 0) ;
    signal al_zus_sri : STD_LOGIC_VECTOR (n-1 downto 0) ;
    
begin
    --al_zus_sll <=  a(n-1 downto 2) << b;
    al_zus_sll <= std_logic_vector(shift_left(unsigned(a(n-1 downto 0)), to_integer(unsigned(b))));      
    --al_zus_srl <= '0'&a(n-1 downto 1);
    al_zus_srl <= std_logic_vector(shift_right(unsigned(a(n-1 downto 0)), to_integer(unsigned(b))));      
    al_zus_srli <= a(n-2 downto 0) & '0';
    al_zus_sra <= a(n-2 downto 0) & '0';
    al_zus_sri <= a(n-2 downto 0) & '0';
    
  
    
    process(s,a,b,al_zus_sll,al_zus_slli)
    begin
    case s is
            when "000" =>
                zUS<=al_zus_sll;
            when "001" =>
                zUS<=al_zus_slli;
            when "010" =>
                zUS<=al_zus_srl;
            when "011" =>
                zUS <= al_zus_srli;
            when "100" =>
                zUS <= al_zus_sra;
            when "101" =>
                 zUS <= al_zus_sri;    
            when others => -- 'U', 'X', '-', etc.
                zUS <= (others => '0');
        end case;
     end process;  
end Behavioral;
