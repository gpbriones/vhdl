----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2023 18:59:25
-- Design Name: 
-- Module Name: Mux_4_to_1_nbits - Behavioral
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

entity Mux_4_to_1_nbits is
    generic(
       n:integer :=32
   );
     Port ( 
     u : in STD_LOGIC_VECTOR (n-1 downto 0);
     v : in STD_LOGIC_VECTOR (n-1 downto 0);
     w : in STD_LOGIC_VECTOR (n-1 downto 0);
     x : in STD_LOGIC_VECTOR (n-1 downto 0);
     m : out STD_LOGIC_VECTOR (n-1 downto 0);
     s : in STD_LOGIC_VECTOR(1 downto 0));
end Mux_4_to_1_nbits;

architecture Behavioral of Mux_4_to_1_nbits is
    component mux_nbits is
     Port ( 
        x : in STD_LOGIC_VECTOR (n-1 downto 0);
        y : in STD_LOGIC_VECTOR (n-1 downto 0);
        z : out STD_LOGIC_VECTOR (n-1 downto 0);
        s : in STD_LOGIC
        );
   end component mux_nbits;
      signal x_m3 :  STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0');
      signal y_m3 :  STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0');
begin
     mux1:mux_nbits 
      port map(
            x => u,
            y => v,
            z => x_m3,
            s => s(0)
             );
      mux2:mux_nbits 
      port map(
         x => w,
         y => x,
         z => y_m3,
         s => s(0)
            );
                       
     mux3:mux_nbits 
     port map(
         x => x_m3,
         y => y_m3,
         z => m,
         s => s(1)
             );

end Behavioral;
