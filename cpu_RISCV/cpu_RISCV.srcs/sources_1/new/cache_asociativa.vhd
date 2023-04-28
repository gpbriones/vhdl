----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2023 20:33:06
-- Design Name: 
-- Module Name: cache_asociativa - Behavioral
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

entity cache_asociativa is
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
end cache_asociativa;

architecture Behavioral of cache_asociativa is
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
     
begin
    c1:cache_256b
    port map(
                --componente => entidad
                address => address,
                data_in => data_in, 
                data_out => data_out,
                hit => hit,
                clk => clk,
                rst => rst,
                we_cache => we_cache
                 );


end Behavioral;
