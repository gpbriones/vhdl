----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2023 20:32:28
-- Design Name: 
-- Module Name: procesador_chip - Behavioral
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

entity procesador_chip is
    generic(
        n:integer :=32
        );
    Port ( 
        clk, rst : in STD_LOGIC);
end procesador_chip;

architecture Behavioral of procesador_chip is

    component CPU is
        generic(
            n:integer :=32
            );
            Port ( 
                clk, rst : in STD_LOGIC;
                --hacia cache
                adreess_to_cache: out STD_LOGIC_VECTOR (n-1 downto 0);
                we_to_cache: out std_logic;
                data_from_rb_to_cache: out std_logic_vector(31 downto 0);
                data_from_cache_to_m2: in std_logic_vector(31 downto 0));
     end component CPU;
     
     component cache_asociativa is
          generic(
        n:integer :=32
        );
          port (
            address:in std_logic_vector(n-1 downto 0);
            data_in: in std_logic_vector(n-1 downto 0);
            data_out: out std_logic_vector(n-1 downto 0);
            hit: out std_logic;
            clk: in std_logic;
            rst: in std_logic;
            we_cache: in std_logic
                );
     end component cache_asociativa;
     
     component RAM_32X8 is
     --  Port ( );
         port (
         addr: in std_logic_vector (31 downto 0);
         we, clk: in std_logic;
         rst: in std_logic;
         data_i: in std_logic_vector(31 downto 0);
         data_o: out std_logic_vector(31 downto 0)
         );
        
     end component RAM_32X8;
     
     signal al_direccion: std_logic_vector(31 downto 0):= ( others => '0');
     signal al_dato_in: std_logic_vector(31 downto 0):= ( others => '0');
     signal al_dato_in_cache: std_logic_vector(31 downto 0):= ( others => '0');
     signal al_dato_in_ram: std_logic_vector(31 downto 0):= ( others => '0');
     signal al_dato_out_from_cache: std_logic_vector(31 downto 0);
     signal al_dato_out_from_principal: std_logic_vector(31 downto 0);
     signal al_dato_out_to_risc: std_logic_vector(31 downto 0);
     signal al_hit: std_logic;
     signal al_we: std_logic;
     signal al_we_to_ram: std_logic:='0';
     signal al_we_cache: std_logic:='0';
begin
    riscv_comp:CPU
    port map(
                --componente => entidad
                clk => clk,
                rst => rst,
                adreess_to_cache =>al_direccion,
                we_to_cache =>al_we,
                data_from_rb_to_cache =>al_dato_in,
                data_from_cache_to_m2 => al_dato_out_to_risc
                );
  
    cache_comp:cache_asociativa
    port map(
    --componente => entidad
        address => al_direccion,
        data_in => al_dato_in, 
        data_out => al_dato_out_from_cache,
        hit => al_hit,
        clk => clk,
        rst => rst,
        we_cache=>al_we_cache
        ); 
        
     memoria_principal:RAM_32X8
      port map(
        --componente => entidad
        addr => al_direccion,
        we => al_we_to_ram,
        clk => clk,
        rst => rst,
        data_i=> al_dato_in,   
        data_o=> al_dato_out_from_principal
        );
        
        
        --al_we_to_ram <= '0';
        --al_dato_out_to_risc <= al_dato_out_from_principal;
    gestion_memoria:
    process(al_hit,al_we,al_we_cache,al_we_to_ram)
    begin 
    if al_hit='1' then
    --se encontro dato en cache
        if al_we='1' then
        --al_we es la señal proveniente del procesador, 
        --como el dato esta en la cache solo se tomara el dato para utilizarse en el procesador
            al_we_cache <='0'; --escritura de cache inhabilitada
            al_we_to_ram<='0'; ---escritura en ram inhabilitada
            al_dato_out_to_risc <= al_dato_out_from_cache;
        end if;
       
    else
        if al_we='1' then
            --al_we es la señal proveniente del procesador, 
            --como el dato no esta en la cache  se tomara el dato desde memoria principal
            al_we_to_ram <='1'; --escritura de RAM Habilitada
            al_dato_in_ram <= al_dato_in; --escribir de risc en mem principal
            al_we_cache <='1'; --escribir en cache
            al_dato_in_cache <= al_dato_in;
            al_dato_out_to_risc <= al_dato_out_from_principal;
            else
            al_we_to_ram <='0'; --escritura de RAM Habilitada
            
             al_we_cache <='0'; --escribir en cache
         end if;
            --no esta en la cache, ir a memoria principal, escriir y luego escribir en cache
 --           
            --pasar dato desde memoria principal
 --           al_dato_out_to_risc <= al_dato_out_from_principal;
            --activar we de cache y grabar el dato de la memoria principal a la cache
 --           al_we_cache<=al_we;
 --           al_dato_in<=al_dato_out_from_principal;
 --       end if;
    end if;
    end process gestion_memoria;
                   
 
end Behavioral;
