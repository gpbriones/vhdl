----------------------------------------------------------------------------------
-- Company: 
-- Engineer: gus
-- 
-- Create Date: 25.01.2023 12:23:50
-- Design Name: 
-- Module Name: FullAdder_4Bits - Behavioral
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

entity FullAdder_4Bits is
     generic(
       n:integer :=4
   );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           c_in : in STD_LOGIC;
           c_out : out STD_LOGIC;
           s : out STD_LOGIC_VECTOR (n-1 downto 0));
end FullAdder_4Bits;

architecture Behavioral of FullAdder_4Bits is
    component FullAdder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c_in : in STD_LOGIC;
           suma : out STD_LOGIC;
           c_out : out STD_LOGIC);
    end component FullAdder;
    --signal al_Cout : STD_LOGIC_VECTOR (2 downto 0);
    signal cin_aux : STD_LOGIC_VECTOR (n downto 0):= (others => '0');
    
begin
    cin_aux(0) <= c_in;
    
    sumador: for i in 0 to n-1 generate
        fa_i:  FullAdder
         port map(
          a => a(i),
          b => b(i), 
          c_in =>  cin_aux(i),
          c_out =>  cin_aux(i+1),
          suma => s(i)
             );
    end generate;
    c_out <= cin_aux(n);
--    FA_1:FullAdder 
--    port map(
--        a => a(0),
--        b => b(0),
--        c_in => '0',
--        c_out => al_Cout(0),
--        suma => s(0)
--           );
           
--    FA_2:FullAdder 
--               port map(
--                   a => a(1),
--                   b => b(1),
--                   c_in => al_Cout(0),
--                   c_out => al_Cout(1),
--                   suma => s(1)
--                      );
--    FA_3:FullAdder 
--    port map(
--    a => a(2),
--    b => b(2),
--    c_in => al_Cout(1),
--    c_out => al_Cout(2),
--    suma => s(2)
--    );
                      
--     FA_4:FullAdder 
--       port map(
--       a => a(3),
--       b => b(3),
--       c_in => al_Cout(2),
--       c_out => c_out,
--       suma => s(3)
--       );
       
end Behavioral;
