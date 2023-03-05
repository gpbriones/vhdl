----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2023 18:19:37
-- Design Name: 
-- Module Name: FullAdder - Behavioral
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

entity FullAdder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c_in : in STD_LOGIC;
           suma : out STD_LOGIC;
           c_out : out STD_LOGIC);
end FullAdder;

architecture Behavioral of FullAdder is
    component mux_case is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           z : out STD_LOGIC;
           s : in STD_LOGIC);
    end component mux_case;
    signal a_xor_out : STD_LOGIC;
begin
    a_xor_out <= a xor b;
    suma <= a_xor_out xor c_in;
 
    mux1:mux_case 
    port map(
        x => b,
        y => c_in,
        z => c_out,
        s => a_xor_out
           );
end Behavioral;
