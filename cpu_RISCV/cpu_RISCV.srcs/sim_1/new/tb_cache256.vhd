----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2023 12:18:25
-- Design Name: 
-- Module Name: tb_cache256 - Behavioral
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

entity tb_cache256 is
--  Port ( );
end tb_cache256;

architecture Behavioral of tb_cache256 is
    component cache_256b is
    generic(
    n:integer :=32
    );
    port (
        address:in std_logic_vector(n-1 downto 0);
        data_in: in std_logic_vector(n-1 downto 0);
        data_out: out std_logic_vector(n-1 downto 0);
        hit: out std_logic;
        clk: in std_logic;
        rst: in std_logic;
        we_cache: in std_logic
            );
    end component cache_256b;
    
    signal clk, rst:  std_logic;
    signal al_address: std_logic_vector(31 downto 0):= (others => '0');
    signal al_data_in:std_logic_vector(31 downto 0):= (others => '0');
    signal al_data_out:  std_logic_vector(31 downto 0);
    signal al_hit:  std_logic;
    signal al_we_cache:  std_logic;
    
    constant periodo: time:=10 ns;
begin
    mapeo_256:cache_256b
     port map(
        address => al_address,
        data_in => al_data_in,
        data_out => al_data_out,
        hit => al_hit,
        clk => clk,
        rst=>rst,
        we_cache => al_we_cache
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
                al_address<=x"00000000";
            else
            --    if clk'event and clk='1' then
                --    al_address<=x"80000000";
                --    al_data_in<=x"10000009";
                --   al_we_cache<='0';
             --   end if;
            end if;
          end process;

end Behavioral;
