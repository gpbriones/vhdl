----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.02.2023 15:27:39
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity Control is
--  Port ( );
    port (
        opcode: in std_logic_vector(6 downto 0);
        rst: in std_logic;
        ctr_alu: out std_logic_vector(2 downto 0);
        m_rd: out std_logic;
        m_wr: out std_logic;
        r_wr: out std_logic;
        reg_dst: out std_logic;
        alu_src: out std_logic;
        jump: out std_logic 
        --reg_dst,mem_to_reg,alu_op: out std_logic_vector(1 downto 0)
        --jump,branch,mem_read,mem_write,alu_src,reg_write,sign_or_zero: out std_logic
    );
end Control;


architecture Behavioral of Control is
    begin
        process(rst,opcode)
        begin
            if(rst = '1') then
                reg_dst <= '0';
                --mem_to_reg <= "00";
                ctr_alu <= "000";
                jump <= '0';
                --branch <= '0';
                m_rd <= '0';
                m_wr <= '0';
                alu_src <= '0';
                r_wr <= '0';
                --sign_or_zero <= '1';
             else 
                case opcode is
                    when "0110011" => -- tipo R
                        reg_dst <= '0';
                        --mem_to_reg <= "00";
                        ctr_alu <= "000";
                        jump <= '0';
--                        branch <= '0';
                        m_rd <= '0';
                        m_wr <= '0';
                        alu_src <= '0';
                        r_wr <= '1';
--                        sign_or_zero <= '1';
                    when "0010011" => -- tipo I
                          reg_dst <= '0';
   --                     mem_to_reg <= "00";
                          ctr_alu <= "001";
     --                   alu_op <= "10";
                          jump <= '0';
--                        branch <= '0';
                          m_rd <= '0';
                          m_wr <= '0';
                          alu_src <= '1';
                          r_wr <= '1';
--                        sign_or_zero <= '0';
                  when "0000011" => -- tipo I para load byte-->lb
                          reg_dst <= '1';
   --                     mem_to_reg <= "00";
                          ctr_alu <= "001";
     --                   alu_op <= "10";
                          jump <= '0';
--                        branch <= '0';
                          m_rd <= '0';
                          m_wr <= '0';  --escritura en memoria principal activa
                          alu_src <= '1';
                          r_wr <= '1';  -- escritura en regitro de memoria
--                        sign_or_zero <= '0';
                  when  "0100011" => -- tipo S para sb, store  byte
                    reg_dst <= '1';
  --                 mem_to_reg <= "00";
                     ctr_alu <= "010";
    --               alu_op <= "00";
                   jump <= '0';
--                   branch <= '0';
                   m_rd <= '0';
                   m_wr <= '1';  --escritura en memoria principal activa
                   alu_src <= '1';
                   r_wr <= '1';  -- escritura en regitro de memoria
--                        sign_or_zero <= '0';
             when  "1100011" => -- tipo B
 --              reg_dst <= "10";
   --            mem_to_reg <= "10";
                 ctr_alu <= "011";
     --          alu_op <= "00";
                 jump <= '1';
--               branch <=  '0';
                 m_rd <=  '0';
                 m_wr <=  '0';
                 alu_src <= '0';
--               reg_write <=  '1';
                 r_wr <= '0';  -- escritura en regitro de memoria

--               sign_or_zero <= '1';
             when  "0110111" => -- tipo U LUI
--               reg_dst <= "00";
  --             mem_to_reg <= "01";
                 ctr_alu <= "100";
    --           alu_op <= "11";
--               jump <= '0';
--               branch <= '0';
--               mem_read <= '1';
--               mem_write <= '0';
--               alu_src <= '1';
--               reg_write <= '1';
--               sign_or_zero <= '1';

             when  "0010111" => -- tipo U AUIPC
--               reg_dst <= "00";
 --             mem_to_reg <= "01";
                ctr_alu <= "101";
   --           alu_op <= "11";
--               jump <= '0';
--               branch <= '0';
--               mem_read <= '1';
--               mem_write <= '0';
--               alu_src <= '1';
--               reg_write <= '1';
--               sign_or_zero <= '1';

             when  "1101111" => -- tipo J
--               reg_dst <= "00";
  --             mem_to_reg <= "00";
                 ctr_alu <= "110";
    --           alu_op <= "11";
--               jump <= '0';
--               branch <= '0';
--               mem_read <= '0';
--               mem_write <= '1';
--               alu_src <= '1';
--               reg_write <= '0';
--               sign_or_zero <= '1'; 
             when others =>   
--                reg_dst <= "01";
  --              mem_to_reg <= "00";
                  ctr_alu <= "111";
    --            alu_op <= "00";
--                jump <= '0';
--                branch <= '0';
--                mem_read <= '0';
--                mem_write <= '0';
--                alu_src <= '0';
--                reg_write <= '1';
--                sign_or_zero <= '1';
             end case;
        end if;
end process;
end Behavioral;
