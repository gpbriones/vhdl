----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2023 10:16:15
-- Design Name: 
-- Module Name: mux_case - Behavioral
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

entity mux_nbits is
     generic(
      n:integer :=32
  );
    Port ( x : in STD_LOGIC_VECTOR (n-1 downto 0);
           y : in STD_LOGIC_VECTOR (n-1 downto 0);
           z : out STD_LOGIC_VECTOR (n-1 downto 0);
           s : in STD_LOGIC);
end mux_nbits;

architecture Behavioral of mux_nbits is

begin
     z <= y when s='1' else x;
end Behavioral;
