----------------------------------------------------------------------------------
-- Company: 
-- Engineer: gus
-- 
-- Create Date: 25.01.2023 12:38:42
-- Design Name: 
-- Module Name: tb_fullAdder4bits - Behavioral
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

entity tb_fullAdder4bits is
--  Port ( );
    generic(
       n:integer :=4
   );
end tb_fullAdder4bits;

architecture Behavioral of tb_fullAdder4bits is
    component FullAdder_4Bits is
     generic(
       n:integer :=4
   );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           c_in : in STD_LOGIC;
           c_out : out STD_LOGIC;
           s : out STD_LOGIC_VECTOR (n-1 downto 0));
    end component FullAdder_4Bits;
    
    
        signal a : STD_LOGIC_VECTOR (n-1 downto 0);
        signal b : STD_LOGIC_VECTOR (n-1 downto 0);
        signal c_in : STD_LOGIC;
        signal suma : STD_LOGIC_VECTOR (n-1 downto 0);
        signal c_out : STD_LOGIC;
begin

      FA_4b:FullAdder_4Bits
      generic map(n=>n)
  port map(
      a => a,
      b => b,
      c_in => c_in,
      c_out => c_out,
      s => suma
         );
         
           process
            begin
                 a <= "0000";
                 b <= "0001";
                 c_in <= '0';
                 wait for 10 ns;
                
                 a <= "0001";
                 b <= "0010";
                 c_in <= '0';
                 wait for 10 ns;
                 
                 a <= "0010";
                 b <= "0011";
                 c_in <= '0';
                 wait for 10 ns;
                 
                 a <= "0011";
                 b <= "0011";
                 c_in <= '0';
                 wait for 10 ns;
                 
                 a <= "0100";
                 b <= "0010";
                 c_in <= '0';
                 wait for 10 ns;
                                  
                 a <= "0101";
                 b <= "0011";
                 c_in <= '0';
                 wait for 10 ns;
                                  
                 a <= "1010";
                 b <= "1010";
                 c_in <= '0';
                 wait for 10 ns;
             end process;
         


end Behavioral;
