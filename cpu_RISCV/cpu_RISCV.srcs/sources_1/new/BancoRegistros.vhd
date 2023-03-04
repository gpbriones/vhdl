----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.02.2023 20:53:49
-- Design Name: 
-- Module Name: BancoRegistros - Behavioral
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

entity BancoRegistros is
--  Port ( );
    generic(
        n:integer :=32
        );
    Port (
        clk, rst, r_we: in std_logic;
        adr : in STD_LOGIC_VECTOR (31 downto 0);
        d : in STD_LOGIC_VECTOR (n-1 downto 0);
        q : inout STD_LOGIC_VECTOR ((n*n)-1 downto 0):= (others => '0'));
        
end BancoRegistros;

architecture Behavioral of BancoRegistros is
    component RegistroD is
        generic(
            n:integer :=32
            );
    Port (
        clk, rst,we: in std_logic;
        d : in STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0');
        q : inout STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0'));
   end component RegistroD;
   signal addr_we :   STD_LOGIC_VECTOR (31 downto 0);
   signal al_d : STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0');
   
begin
    addr_we<=adr;
    --proceso para setear bandera write-enable general
--    process(clk,r_we,addr_we,rst)
--        begin
--            if rst = '1' then 
--                addr_we<=x"00000000";
--                al_d <= x"00000000";
--            else
--                if clk'event and clk = '1' then
--                    if(r_we = '0') then
--                        addr_we<=x"00000000";
--                        al_d <= d;
--                    else
--                     addr_we<=adr;
--                     al_d <= d;
--                end if;
--             end if;
--           end if; 
           
--    end process;
     
    Banco_32_registros: for i in 0 to n-1 generate
    
        registro_d:  RegistroD
            port map(
                
                --componente => entidad
                d => d,
                q => q ((((n)*(i+1))-1) downto (n)*(i)), 
                we => addr_we(i),
                clk => clk,
                rst => rst
                 );
    end generate;
    
end Behavioral;
