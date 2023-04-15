----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2023 12:47:52
-- Design Name: 
-- Module Name: ROM - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
--  Port ( );
    generic(
      n:integer :=32
  );
        port (
                addr: in std_logic_vector (31 downto 0);
                data_o: inout std_logic_vector(n-1 downto 0));

end ROM; 
architecture Behavioral of ROM is
    subtype WordLen is  std_logic_vector(n-1 downto 0);
    
    type WordArray is array (0 to 31) of WordLen; 
     constant memoria : WordArray :=(
     --x"00500093",	--addi x1 x0 5	addi x1,x0,5
     --x"00200113",    --addi x2 x0 2    addi x2,x0,2
     --x"00500113",    --addi x2 x0 5   addi x2,x0,2
     --x"0020c1b3",    --xor x3 x1 x2    xor x3,x1,x2
     --x"40218233",    --sub x4 x3 x2    sub x4,x3,x2
     --x"0020e233",    --or x4 x1 x2    or x4,x1,x2
     --x"0020f2b3",    --and x5 x1 x2    and x5,x1,x2
     --x"00119333",    --sll x6 x3 x1    sll x6,x3,x1
     --x"0020d3b3",    --srl x7 x1 x2    srl x7,x1,x2
     --x"00208183",    --lb x3 2(x1)    lb x3, 2(x1)
     --x"00208663",    --beq x1 x2 12    beq x1,x2,ETIQUETA
     --x"0050c193",    --xori x3 x1 5    xori x3,x1,5
     --x"0060e213",    --ori x4 x1 6    ori x4,x1,6
     --x"0060f013",    --andi x5 x1 6    andi x5,x1,6
     	--PC	Machine Code	Basic Code	Original Code
 
        x"00500093", --addi x1 x0 5    addi x1,x0,5
        x"00200113", --addi x2 x0 2    addi x2,x0,2
         
 --        x"0020C1B3", --xor x3 x1 x2    xor x3,x1,x2
 --        x"40218233", --sub x4 x3 x2    sub x4,x3,x2
 --        x"0020E233", --or x4 x1 x2 or x4,x1,x2
 --        x"0020F2B3", --and x5 x1 x2    and x5,x1,x2
 --        x"00219333", --sll x6 x3 x2    sll x6,x3,x2
 --        x"0021D3B3", --srl x7 x3 x2    srl x7,x3,x2
--         x"00208123", --sb x2 2(x1) sb x2, 2(x1)
--         x"00208183", --lb x3 2(x1) lb x3, 2(x1)
--         x"00208863", --beq x1 x2 16    beq x1,x2,ETIQUETA
--         x"0050C193", --xori x3 x1 5    xori x3,x1,5
--         x"0060E213", --ori x4 x1 6 ori x4,x1,6
--         x"00110113", --addi x2 x2 1    addi x2,x2,1
--         x"0060F293", --andi x5 x1 6    andi x5,x1,6
               
           
           others =>x"00000000"
           );
begin
   data_o <= memoria(conv_integer(addr(4 downto 0)));
end Behavioral;
