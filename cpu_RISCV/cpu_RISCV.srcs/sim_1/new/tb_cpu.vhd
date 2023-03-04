----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2023 12:27:47
-- Design Name: 
-- Module Name: tb_cpu - Behavioral
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

entity tb_cpu is
--  Port ( );
end tb_cpu;

architecture Behavioral of tb_cpu is
    component CPU is
        generic(
            n:integer :=32
        );
     Port ( 
        clk, rst : in STD_LOGIC);
    end component CPU;
     signal clk, rst:  std_logic;
     
     constant periodo: time:=10 ns;
begin
     mapeo_cpu:CPU
     port map(
     clk => clk,
     rst=>rst
     );
     
     
     process
     begin
        rst<='1';
        wait for 5 ns;
        rst<='0';
        wait for periodo*80;
     end process;
     
     
     process
     begin
       -- rst<='0';
        clk<='0';
        wait for periodo;
        clk<='1';
        wait for periodo;
     end process;
     
--     ff : process
--        begin
--            rst<='1';
--        wait for periodo*4;
--            rst<='0';
--        end process;


end Behavioral;
