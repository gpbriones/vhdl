----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2023 20:43:39
-- Design Name: 
-- Module Name: cache_256b - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cache_256b is
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
end cache_256b;

architecture Behavioral of cache_256b is
    --palabra = v+tag+ data
    subtype palabra_b is std_logic_vector(54 downto 0);
    -- numero bloques = 2 a la 8, n=:numero de bits de index = 8
    type palabra_b_array is array(0 to 255) of palabra_b;
    signal cache: palabra_b_array:= ( others => (others =>'0'));
    
    signal valid_bit: std_logic:='0'; --1 valido, 0 no valido
    -- tag = bits de direccion - (n+m+2)
    --bits de direccion = 32
    -- n: bits de indice = 8 para 256 bloques
    --m = 0 para ¨2 a la 0 palabras, es decir una palabra de 4 bytes
    --tag = 32 - (8+0+2) =22
    --data_in = 2 a la m+2 bytes = 4 bytes = 32 bits
    signal al_tag: std_logic_vector (21 downto 0):= (others => '0');
    signal al_tag_bloque: std_logic_vector (21 downto 0):= (others => '0');
    signal al_indice:  std_logic_vector (7 downto 0):= (others => '0');
    signal al_bloque:  std_logic_vector (54 downto 0):= (others => '0');
    signal al_hit :std_logic:='0';
    
    signal al_address: std_logic_vector(n-1 downto 0);
    signal al_data_in: std_logic_vector(n-1 downto 0);
    signal al_data_out: std_logic_vector(n-1 downto 0);
    
begin
 --   al_indice <= address(9 downto 2);
 --   al_tag <= address(31 downto 10);
 --   cache( conv_integer(al_indice))(54) <= '1';
--    al_bloque<= cache( conv_integer(al_indice));

-- proceso de 
    initialize: process(rst)
    begin
        if  rst = '1' then
         al_data_out<=  (others => '0');
        end if;
    end process initialize;
    
    
     --asignacion de indice desde la direccion de entrada
     al_indice <= address(9 downto 2);
     --asignacion de tag
     al_tag <= address(31 downto 10);
     --se obtiene bloque
     al_bloque <= cache( conv_integer(al_indice));
     --se obtiene bit vrificador
     valid_bit <= al_bloque(54);
     --se obtiene tag de bloque
     al_tag_bloque <= al_bloque(53 downto 32);
     process(clk,address)
       begin
           if clk'event and clk='1' then
                -- escribir data en memoria cache
                if we_cache = '1' then
                    cache( conv_integer(al_indice))(31 downto 0) <= data_in;
                    cache( conv_integer(al_indice))(53 downto 32) <= al_tag; 
                    cache( conv_integer(al_indice))(54) <= '1'; 
                   -- cache( conv_integer(al_indice))(53) <= '1'; 
                else
                    --seteo manual para pruebas
                    --cache( conv_integer(al_indice))(54) <= '1';
                    --cache( conv_integer(al_indice))(53) <= '1';
                    --logica para  obtener hit o miss
                    if (valid_bit='1' and (al_tag = al_tag_bloque ) )then
                         --hit, asignacion de datos desde cache
                         al_hit <= '1';
                     else
                         al_hit <= '0';
                         --se tiene que leer desde memoria y guardar en cache
                     end if;    
                end if;  
           end if;
        data_out<= al_bloque(31 downto 0);  
       end process;
    hit<=al_hit;
end Behavioral;