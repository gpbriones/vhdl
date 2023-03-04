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

entity DEMUX_32X1 is
     generic(
     n:integer :=32
    );
    Port ( entrada : in STD_LOGIC_VECTOR (4 downto 0);
           salida : out STD_LOGIC_VECTOR (n-1 downto 0));
end DEMUX_32X1;

architecture Behavioral of DEMUX_32X1 is

begin
    process (entrada)
    begin
        case entrada is
        
        when "00000"=> salida <= "00000000000000000000000000000001";
        when "00001"=> salida <= "00000000000000000000000000000010";
        when "00010"=> salida <= "00000000000000000000000000000100";
        when "00011"=> salida <= "00000000000000000000000000001000";
        when "00100"=> salida <= "00000000000000000000000000010000";
        when "00101"=> salida <= "00000000000000000000000000100000";
        when "00110"=> salida <= "00000000000000000000000001000000";
        when "00111"=> salida <= "00000000000000000000000010000000";
        when "01000"=> salida <= "00000000000000000000000100000000";
        when "01001"=> salida <= "00000000000000000000001000000000";
        when "01010"=> salida <= "00000000000000000000010000000000";
        when "01011"=> salida <= "00000000000000000000100000000000";
        when "01100"=> salida <= "00000000000000000001000000000000";
        when "01101"=> salida <= "00000000000000000010000000000000";
        when "01110"=> salida <= "00000000000000000100000000000000";
        when "01111"=> salida <= "00000000000000001000000000000000";
        when "10000"=> salida <= "00000000000000010000000000000000";
        when "10001"=> salida <= "00000000000000100000000000000000";
        when "10010"=> salida <= "00000000000001000000000000000000";
        when "10011"=> salida <= "00000000000010000000000000000000";
        when "10100"=> salida <= "00000000000100000000000000000000";
        when "10101"=> salida <= "00000000001000000000000000000000";
        when "10110"=> salida <= "00000000010000000000000000000000";
        when "10111"=> salida <= "00000000100000000000000000000000";
        when "11000"=> salida <= "00000001000000000000000000000000";
        when "11001"=> salida <= "00000010000000000000000000000000";
        when "11010"=> salida <= "00000100000000000000000000000000";
        when "11011"=> salida <= "00001000000000000000000000000000";          
        when "11100"=> salida <= "00010000000000000000000000000000";
        when "11101"=> salida <= "00100000000000000000000000000000";
        when "11110"=> salida <= "01000000000000000000000000000000";
        when "11111"=> salida <= "10000000000000000000000000000000";
        
        when others => salida <= (others=>'0');
        end case;
end process;

end Behavioral;
