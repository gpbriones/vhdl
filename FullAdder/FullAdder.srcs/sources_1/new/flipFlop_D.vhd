----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2023 19:06:44
-- Design Name: gpb
-- Module Name: flipFlop_D - Behavioral
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
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flipFlop_D is
    generic(
       n:integer :=4
   );
    Port ( d: in STD_LOGIC_VECTOR (n-1 downto 0);
           clk: in STD_LOGIC;
           q : inout STD_LOGIC_VECTOR (n-1 downto 0));
end flipFlop_D;
    
architecture Behavioral of flipFlop_D is

begin
    process(clk)
        begin
            if(clk='1' and clk'event) then
                q<=d;
            else
                q<=q;
            end if;
    end process;
end Behavioral;
