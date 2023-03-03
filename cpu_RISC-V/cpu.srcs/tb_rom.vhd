----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2023 13:48:23
-- Design Name: 
-- Module Name: tb_rom - Behavioral
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

entity tb_rom is
--  Port ( );
end tb_rom;
    
architecture Behavioral of tb_rom is
    component ROM is
--  Port ( );
    generic(
          n:integer :=32
    );
        port (
                addr: in std_logic_vector (15 downto 0);
                data_o: inout std_logic_vector(n-1 downto 0));

end component ROM; 
    signal addr:  std_logic_vector (15 downto 0);
    signal data_o:  std_logic_vector(31 downto 0);
begin
    memoria_rom:ROM
      port map(
      addr => addr,
      data_o => data_o
      );
      
       ff : process
                begin
                 addr<=x"0001";
                 --data_o <= data_o;
                 wait for 10 ns;
                 --d <= x"00000001";
                 -- addr<="00001";
                  --data_o <= data_o;
                 --wait for 30 ns;
                 --d <= x"00000000";
                 -- addr<="00010";
                 -- data_o <= data_o;
                 --wait for 10 ns;
                 --d <= x"00000000";
                 --wait for 20 ns;
                 
               
               end process;
         

end Behavioral;
