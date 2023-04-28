----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2023 10:23:34
-- Design Name: 
-- Module Name: Codificador - Behavioral
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

entity Codificador is
    generic(
        r:integer :=11
        );
    Port (
        input:in std_logic;
        clk:in std_logic;
        we:in std_logic;
        rst:in std_logic);
end Codificador;

architecture Behavioral of Codificador is
    component FlipFlop is
     Port ( clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            d : in STD_LOGIC;
            we : in STD_LOGIC;
            q : inout STD_LOGIC);
     end component FlipFlop;
     
     signal al_xor: std_logic_vector(r-1 downto 0):= (others => '0');
     signal g: std_logic_vector(r-1 downto 0);
begin
    registro_0:  FlipFlop
        port map(
                --componente => entidad
                d => input,
                q => g(1), 
                we => '1',
                clk => clk,
                rst => rst
                 );
        g(0)<= input;        
        al_xor(0) <= g(0) xor g(1); 
        
    r_registros: for i in 0 to r-3 generate
    registro_d:  FlipFlop
        port map(
                --componente => entidad
                d => g(i+1),
                q => g(i+2), 
                we => '1',
                clk => clk,
                rst => rst
                 );
        al_xor(i+1) <= al_xor(i) xor g(i+2);
    end generate;         
end Behavioral;
