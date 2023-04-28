----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2023 10:39:02
-- Design Name: 
-- Module Name: FlipFlop - Behavioral
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

entity FlipFlop is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           d : in STD_LOGIC;
           we : in STD_LOGIC;
           q : inout STD_LOGIC);
end FlipFlop;

architecture Behavioral of FlipFlop is
begin
    process(clk, we,rst)
        begin
            if rst = '1' then 
            q<='0';
                else
            if clk'event and clk='1' then
                if we='1' then
                    q <= d;
                  else
                    q <= q;
                end if;
            end if;
       end if;
    end process;
end Behavioral;
