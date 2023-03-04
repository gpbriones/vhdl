----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2023 00:02:10
-- Design Name: 
-- Module Name: RAM_32X8 - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_32X8 is
--  Port ( );
    port (
    addr: in std_logic_vector (31 downto 0);
    we, clk: in std_logic;
    rst: in std_logic;
    data_i: in std_logic_vector(31 downto 0);
    data_o: out std_logic_vector(31 downto 0));
   
end RAM_32X8;

architecture Behavioral of RAM_32X8 is
    type ram_table is array (0 to 1023) of std_logic_vector(31 downto 0);
    signal rammemory: ram_table:= (others => (others => '0')); -- inicializa la memoria en 0  
begin
    process( we,clk, addr,rst)
        begin
        if  rst = '1' then
             data_o<=x"00000000";
        else 
            if clk'event and clk='1' then
                if we='1' then
                    rammemory(conv_integer(addr))<=data_i;
                end if;
                data_o <= data_i;
            end if;
       end if;
    end process;
    
end Behavioral;
