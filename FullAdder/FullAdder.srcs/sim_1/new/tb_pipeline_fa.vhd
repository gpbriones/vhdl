----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2023 20:39:54
-- Design Name: 
-- Module Name: tb_pipeline_fa - Behavioral
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

entity tb_pipeline_fa is
--  Port ( );
    generic(
     -- se crearan 4 sumadores completos de 4 bits cada uno, 
     --con pipeline
      n:integer :=16
  );
end tb_pipeline_fa;

architecture Behavioral of tb_pipeline_fa is
    component PipeLine4FA4B is
     generic(
     -- se crearan 4 sumadores completos de 4 bits cada uno, 
     --con pipeline
      n:integer :=16
  );
   Port ( Ap : in STD_LOGIC_VECTOR (n-1 downto 0);
          Bp : in STD_LOGIC_VECTOR (n-1 downto 0);
          Cp_in : in STD_LOGIC;
          clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          Cp_out : out STD_LOGIC;
          Sp : out STD_LOGIC_VECTOR (n-1 downto 0));
    end component PipeLine4FA4B;
    signal clk, rst:  std_logic;
    signal Cp_in:  std_logic;
    signal Cp_out:  std_logic;
    signal Ap : STD_LOGIC_VECTOR (n-1 downto 0);
    signal Bp : STD_LOGIC_VECTOR (n-1 downto 0);
    signal Sp : STD_LOGIC_VECTOR (n-1 downto 0);
    constant periodo: time:=10 ns;
    
begin
      mapeo_pipeline:PipeLine4FA4B
       port map(
         Ap => Ap,
         Bp=> Bp,
         Cp_in =>Cp_in,
         clk => clk,
         rst => rst,
         Cp_out =>Cp_out,
         Sp => Sp
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
               
               
                Ap(3 downto 0) <= "0000";
                Bp(3 downto 0) <= "0001";
                Cp_in <= '0';
                          
                              
                Ap(7 downto 4) <= "0001";
                Bp(7 downto 4) <= "0010";
          
                               
                Ap(11 downto 8) <= "0010";
                Bp(11 downto 8) <= "0011";
                               
                Ap(15 downto 12) <= "0011";
                Bp(15 downto 12) <= "0011";
                               
                               
               Ap(3 downto 0) <= "0100";
               Bp(3 downto 0) <= "0010";
                                                
               Ap(7 downto 4)<= "0101";
               Bp(7 downto 4) <= "0011";
                                                
               Ap(11 downto 8) <= "1010";
               Bp(11 downto 8) <= "1010";

            end process;

end Behavioral;
