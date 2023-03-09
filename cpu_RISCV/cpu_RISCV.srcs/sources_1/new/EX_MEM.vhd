----------------------------------------------------------------------------------
-- Company: 
-- Engineer: gpb
-- 
-- Create Date: 27.01.2023 19:06:44
-- Design Name: gpb
-- Module Name: IF_ID
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Registro para etapa Execute/Mem
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

entity EX_MEM is
    generic(
       n:integer :=132
   );
    Port ( we, clk, rst: in std_logic;
           d : in STD_LOGIC_VECTOR (n-1 downto 0);
           q : inout STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0'));
end EX_MEM;
    
architecture Behavioral of EX_MEM is

begin
    process(clk, we,rst)
    begin
    if rst = '1' then 
        q<=(others => '0');
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
