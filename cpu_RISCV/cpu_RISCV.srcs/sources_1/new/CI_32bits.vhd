----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2023 20:39:50
-- Design Name: 
-- Module Name: CI_32bits - Behavioral
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

entity CI_32bits is
     generic(
      n:integer :=32
  );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           z : out STD_LOGIC_VECTOR (n-1 downto 0);
           s : in STD_LOGIC_VECTOR (1 downto 0));
end CI_32bits;

architecture Behavioral of CI_32bits is
    component Mux_4_to_1_nbits is
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
    end component Mux_4_to_1_nbits;
    signal al_and_out :  STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0');
    signal al_or_out :  STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0');
    signal al_xor_out :  STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0');
    signal al_not_out :  STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0');
begin
    al_and_out <= a and b;
    al_or_out <= a or b;
    al_xor_out <= a xor b;
    al_not_out <= not a;
    
    mux4x1:Mux_4_to_1_nbits 
      port map(
            u => al_and_out,
            v => al_or_out,
            w => al_xor_out,
            x => al_not_out,
            m => z,
            s => s
             );

end Behavioral;
