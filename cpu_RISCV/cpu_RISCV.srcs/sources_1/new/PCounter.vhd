----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2023 17:02:54
-- Design Name: 
-- Module Name: PCounter - Behavioral
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

entity PCounter is
--  Port ( );
    Port ( 
        clk,rst: in STD_LOGIC;
        we: in STD_LOGIC;
        pc_in : in STD_LOGIC_VECTOR (31 downto 0);
        pc_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
end PCounter;

architecture Behavioral of PCounter is   
    signal current_pc: std_logic_vector( 31 downto 0) := X"00000000";
    
    begin      
 
   process(clk,rst) 
    begin
        if rst = '1' then 
            current_pc <=x"00000000"; 
        else
            if clk'event and clk = '1' then
                if we = '1' then
                            current_pc <= std_logic_vector(unsigned(current_pc) + unsigned(pc_in));
                end if;
            end if;
        end if;  
   end process;   
   pc_out <= current_pc;     
end Behavioral;
