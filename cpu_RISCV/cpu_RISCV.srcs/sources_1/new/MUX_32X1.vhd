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

entity MUX_32X1 is
     generic(
     n:integer :=32
    );
    Port ( entrada : in STD_LOGIC_VECTOR ((n*n)-1 downto 0);
           sel : in STD_LOGIC_VECTOR (4 downto 0);
           salida : out STD_LOGIC_VECTOR (n-1 downto 0));
end MUX_32X1;

architecture Behavioral of MUX_32X1 is

begin
    process (sel,entrada)
    begin
        case sel is
        when "00000" => salida <= entrada(31 downto 0);
        when "00001" => salida <= entrada(63 downto 32);
        when "00010" => salida <= entrada(95 downto 64);
        when "00011" => salida <= entrada(127 downto 96);
        when "00100" => salida <= entrada(159 downto 128);
        when "00101" => salida <= entrada(191 downto 160);
        when "00110" => salida <= entrada(223 downto 192);
        when "00111" => salida <= entrada(255 downto 224);
        when "01000" => salida <= entrada(287 downto 256);
        when "01001" => salida <= entrada(319 downto 288);
        when "01010" => salida <= entrada(351 downto 320);
        when "01011" => salida <= entrada(383 downto 352);
        
        when "01100" => salida <= entrada(415 downto 384);
                when "01101" => salida <= entrada(447 downto 416);
                when "01110" => salida <= entrada(479 downto 448);
                when "01111" => salida <= entrada(511 downto 480);
                when "10000" => salida <= entrada(543 downto 512);
                when "10001" => salida <= entrada(575 downto 544);
                when "10010" => salida <= entrada(607 downto 576);
                when "10011" => salida <= entrada(639 downto 608);
                when "10100" => salida <= entrada(671 downto 640);
                when "10101" => salida <= entrada(703 downto 672);
                when "10110" => salida <= entrada(735 downto 704);
                when "10111" => salida <= entrada(767 downto 736);
                when "11000" => salida <= entrada(799 downto 768);
                when "11001" => salida <= entrada(831 downto 800);
                when "11010" => salida <= entrada(863 downto 832);
                when "11011" => salida <= entrada(895 downto 864);
        
                when "11100" => salida <= entrada(927 downto 896);
                when "11101" => salida <= entrada(959 downto 928);
                when "11110" => salida <= entrada(991 downto 960);
                when "11111" => salida <= entrada(1023 downto 992);
        when others => salida <= (others=>'0');
        end case;
end process;

end Behavioral;
