----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2023 00:02:18
-- Design Name: 
-- Module Name: ALU_CONTROL - Behavioral
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

entity ALU_CONTROL is
    Port ( 
           tipo_inst : in STD_LOGIC_VECTOR(2 downto 0);
           func3 : in STD_LOGIC_VECTOR(2 downto 0);
           func12 : in STD_LOGIC_VECTOR(11 downto 0);
           rst: in std_logic;
           ope_out : out STD_LOGIC_VECTOR(5 downto 0) );
end ALU_CONTROL;

architecture Behavioral of ALU_CONTROL is
    ---senal func7 a apartir de func12
   -- signal func7:  STD_LOGIC_VECTOR(7 downto 0); 
begin
    process(rst,tipo_inst,func3,func12)
        begin
           if(rst = '1') then
                ope_out<="000000";
           else 
            case tipo_inst is
                   when "000" => -- tipo R
                        --clasificacion de operacion  segun func3
                        case func3 is
                             when "000" =>  --operacion tipo R
                                if(func12(11 downto 5)= "0000000")then 
                                    ope_out<="000000"; --R suma ok
                                else
                                    ope_out<="000001"; --R resta ok
                                end if;
                             when "001" => 
                                ope_out<="001000"; --R sll ok
                             when "010" => 
                                ope_out<="001010"; --R slt 
                             when "011" => 
                                ope_out<="000100"; --R sltu 
                             when "100" => 
                                ope_out<="000110"; --R xor ok
                             
                             when "101" => 
                                if(func12(11 downto 5)= "0000000")then 
                                    ope_out<="001010"; --R srl ok
                                else
                                    ope_out<="000111"; --R sra
                                end if;
                             when "110" => 
                                    ope_out<="000101"; --R or ok
                             when "111" => 
                                    ope_out<="000100"; --R and  ok                                    
                             when others => 
                             ope_out <=(others => '0');  
                         end case;
      --------------------------------------------------
      --------------------------------------------------                   
                   when "001" => -- tipo I
                        case func3 is
                             when "000" => ope_out<="000000"; --I addi ok
                             
                             when "100" => ope_out<="000110"; --I xori ok
                             
                             when "110" => ope_out<="000101"; --I ori ok
                             
                             when "111" => ope_out<="000100"; --I andi  ok 
                             
                             when others => 
                             ope_out <=(others => '0');  
                        end case;
      ---------------------------------------------------
      ---------------------------------------------------
      
                   when  "010" => -- tipo S
                        case func3 is
                             when "000" => ope_out<="000000";
                             when others => 
                             ope_out <=(others => '0');  
                        end case;
                   when  "011" => -- tipo B
                        case func3 is
                            when "000" => ope_out<="010000";
                            when others => 
                            ope_out <=(others => '0');  
                        end case;
                    when  "100" => -- tipo U LUI
                        ope_out<="000000";
                    when  "101" => -- tipo U AUIPC
                        ope_out<="000000";
                    when  "110" => -- tipo J JAL
                        ope_out<="000000";
                    when others => 
                        ope_out <=(others => '0');  
                end case;
       end if;
end process;


end Behavioral;
