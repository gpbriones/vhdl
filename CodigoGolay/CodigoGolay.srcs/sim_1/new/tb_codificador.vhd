----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2023 12:54:34
-- Design Name: 
-- Module Name: tb_codificador - Behavioral
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

entity tb_codificador is
--  Port ( );
end tb_codificador;

architecture Behavioral of tb_codificador is

component Codificador is
    generic(
        r:integer :=11
        );
    Port (
        input:in std_logic;
        clk:in std_logic;
        we:in std_logic;
        rst:in std_logic);
end component Codificador;
   
   signal clk, rst:  std_logic;
   signal al_input:  std_logic;
   
   constant periodo: time:=10 ns;
begin
   cod:Codificador
    port map(
       input => al_input,
       clk => clk,
       rst=>rst,
       we => '1'
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
    
    process(clk)
         begin
           if rst = '1' then
               al_input<='1';
           else
           --    if clk'event and clk='1' then
               --    al_address<=x"80000000";
               --    al_data_in<=x"10000009";
               --   al_we_cache<='0';
            --   end if;
           end if;
         end process;

end Behavioral;
