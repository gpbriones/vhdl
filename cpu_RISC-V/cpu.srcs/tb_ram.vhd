----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2023 00:06:18
-- Design Name: 
-- Module Name: tb_ram - Behavioral
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

entity tb_ram is
--  Port ( );
end tb_ram;
    
architecture Behavioral of tb_ram is
    component RAM_32X8 is
--  Port ( );
    port (
    addr: in std_logic_vector (31 downto 0);
    we, clk: in std_logic;
    data_i: in std_logic_vector(31 downto 0);
    data_o: out std_logic_vector(31 downto 0));
end component RAM_32X8;
        signal addr :  STD_LOGIC_VECTOR (31 downto 0);
        signal we, clk:  STD_LOGIC;
        signal data_i :  STD_LOGIC_VECTOR (31 downto 0);
        signal data_o:  std_logic_vector(31 downto 0);
        
constant periodo: time:=10 ns;
begin
     process
    begin
        clk<='0';
           wait for periodo;
           clk<='1';
           wait for periodo;
    end process;
    
      reg_d:RAM_32X8
      port map(
      addr => addr,
      we => we,
      clk => clk,
      data_i => data_i,
      data_o => data_o
      );
      
       ff : process
                begin
          --       clk<= '0';
                 addr<=x"00000000";
                 we <= '1';
                 --d <= x"04000000";
                 data_i <= x"00000001";
                 
                 wait for 10 ns;
            --     clk<= '1';
                 data_i <= x"00000003";
                 --d <= x"00000001";
                  addr<=x"00000100";
                 wait for 30 ns;
                 
          --       clk<= '0';
                 --d <= x"00000000";
                 data_i <= x"00000003";
                  addr<=x"00001000";
                 wait for 10 ns;
            --     clk<= '1';
                 --d <= x"00000000";
                 wait for 20 ns;
               end process;


end Behavioral;
