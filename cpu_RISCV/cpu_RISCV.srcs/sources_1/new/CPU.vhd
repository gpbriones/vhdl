------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity CPU is
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
    
end CPU;

architecture Behavioral of CPU is
--------------------------------------
--componente ROM para CPU
---------------------------------------
    component ROM is
    --  Port ( );
        generic(
        n:integer :=32
    );
         port (
                addr: in std_logic_vector (31 downto 0);
                data_o: inout std_logic_vector(n-1 downto 0));
    end component ROM;
----------------------------------------
---- ALU para CPU
-----------------------------------------
    component ALU is
        generic(
              n:integer :=32
          );
        Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
               b : in STD_LOGIC_VECTOR (n-1 downto 0);
               s : in STD_LOGIC_VECTOR (5 downto 0);
               c_in : in STD_LOGIC;
               c_out : out STD_LOGIC;
               z : out STD_LOGIC_VECTOR (n-1 downto 0));
    end component ALU;
----------------------------------------
    ---- MUX 32x1
-----------------------------------------
    component MUX_32X1 is
     generic(
     n:integer :=32
    );
    Port ( entrada : in STD_LOGIC_VECTOR ((n*n)-1 downto 0);
           sel : in STD_LOGIC_VECTOR (4 downto 0);
           salida : out STD_LOGIC_VECTOR (n-1 downto 0));
end component MUX_32X1;

----------------------------------------
    ---- DEMUX 1x32: UNA ENTRADA DE 32BITS 32 SALIDAS DE 1 BIT
-----------------------------------------
component DEMUX_32X1 is
     generic(
     n:integer :=32
    );
    Port ( entrada : in STD_LOGIC_VECTOR (4 downto 0);
           salida : out STD_LOGIC_VECTOR (n-1 downto 0));
end component DEMUX_32X1;
----------------------------------------
    ---- banco de 31 registros
--    RISC-V tiene 32 registros enteros y,
--    cuando se implementa la extensión de punto flotante,
--    32 registros de punto flotante. 
--    A excepción de las instrucciones de acceso a la memoria, 
--    las instrucciones solo se refieren a los registros.
-----------------------------------------
component BancoRegistros is
--  Port ( );
    generic(
        n:integer :=32
        );
    Port (
        clk, rst,r_we: in std_logic;
        adr : in STD_LOGIC_VECTOR (31 downto 0);
        d : in STD_LOGIC_VECTOR (n-1 downto 0);
        q : inout STD_LOGIC_VECTOR ((n*n)-1 downto 0):= (others => '0'));     
end component BancoRegistros;

----------------------------------------
    ---- PCounter: contador de programa
-----------------------------------------
component PCounter is
--  Port ( );
    Port ( 
        clk,rst: in STD_LOGIC;
        we: in STD_LOGIC;
        pc_in : in STD_LOGIC_VECTOR (31 downto 0);
        pc_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
end component PCounter;

----------------------------------------
    ---- CONTROL: 
-----------------------------------------
component Control is
    port (
        opcode: in std_logic_vector(6 downto 0);
        rst: in std_logic;
        ctr_alu: out std_logic_vector(2 downto 0);
        jump:out std_logic;
        m_rd: out std_logic;
        m_wr: out std_logic;
        r_wr: out std_logic;
        reg_dst: out std_logic;
        alu_src:out std_logic
    );
end component Control;

----------------------------------------
    ---- MUX 2x1: 
-----------------------------------------
component MUX_2X1 is
     generic(
     n:integer :=32
    );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           sel : in STD_LOGIC;
           z : out STD_LOGIC_VECTOR (n-1 downto 0));
end component MUX_2X1;

----------------------------------------
    ---- ALU_CONTROL:: Especificacion de operacione a la ALU
-----------------------------------------
component ALU_CONTROL is
    Port ( 
           tipo_inst : in STD_LOGIC_VECTOR(2 downto 0);
           func3 : in STD_LOGIC_VECTOR(2 downto 0);
           func12 : in STD_LOGIC_VECTOR(11 downto 0);
           rst: in std_logic;
           ope_out : out STD_LOGIC_VECTOR(5 downto 0) );
end component ALU_CONTROL;

----------------------------------------
    ---- RAM_32X8:: 
-----------------------------------------
component RAM_32X8 is
--  Port ( );
    port (
    addr: in std_logic_vector (31 downto 0);
    we, clk: in std_logic;
    rst: in std_logic;
    data_i: in std_logic_vector(31 downto 0);
    data_o: out std_logic_vector(31 downto 0));
    
end component RAM_32X8;
---------------------------------------
---seniales
---------------------------------------
    signal add_rom: STD_LOGIC_VECTOR (31 downto 0);
    signal to_mux_RA: STD_LOGIC_VECTOR (4 downto 0);
    signal to_mux_RB: STD_LOGIC_VECTOR (4 downto 0);
    signal to_banco_add: STD_LOGIC_VECTOR (4 downto 0);
    signal to_banco_addvector32: STD_LOGIC_VECTOR (n-1 downto 0);
    
    signal senial_d_from_mux2_out: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_alu_to_m2_in: STD_LOGIC_VECTOR (n-1 downto 0);
    
    signal senial_d_to_muxes: STD_LOGIC_VECTOR ((n*n)-1 downto 0);
    
    signal senial_muxRA_to_alu: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_muxRB_to_alu: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_mux2x1_to_alu: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_mem_p_to_m2: STD_LOGIC_VECTOR (n-1 downto 0);
    
    
    signal senial_selector_to_alu: STD_LOGIC_VECTOR (5 downto 0);
    
    signal to_code_operation: STD_LOGIC_VECTOR (6 downto 0);
    signal al_func3: STD_LOGIC_VECTOR (2 downto 0);
    signal to_12b: STD_LOGIC_VECTOR (11 downto 0);
    signal to_7b: STD_LOGIC_VECTOR (6 downto 0);
    
    --seniales de control:
    --senial de control para habilitar/deshabilitar banco de registros
    signal ctr_r_we: STD_LOGIC;
    signal ctr_to_rd_data: STD_LOGIC;
    signal ctr_to_wr_data: STD_LOGIC;
    signal ctr_to_alu: STD_LOGIC_VECTOR (2 downto 0);
    signal ctr_alu_source: STD_LOGIC;
    signal ctr_to_reg_dst: STD_LOGIC;
    signal ctr_jump: STD_LOGIC;
    
    --senial extensor de bits
    signal al_extensor: STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_extensor_31_25_y_11_7: STD_LOGIC_VECTOR (n-1 downto 0);
    
    
    signal senial_mux2x1_salto_out_to_mux_suma_in: STD_LOGIC_VECTOR (n-1 downto 0);
    signal signal_mux_suma_to_pc_counter: STD_LOGIC_VECTOR (n-1 downto 0);
    
    
    
    --senial de salida de alu
    signal al_and_out: STD_LOGIC;
begin

    ---extensor de bits para operaciones inmediatas:
    al_extensor <= x"00000"&to_7b&to_mux_RB;
    --funcion de 12 bits
    to_12b <= to_7b&to_mux_RB;
    --R <= std_logic_vector(to_signed(to_integer(signed(X) / signed(Y)),32));
    --extensor para salto
    --con divisor entre 4, corrimiento -->
    al_extensor_31_25_y_11_7 <= "00"&x"00000"&to_7b&to_banco_add(4 downto 2);
    --mapeo de puertos de los componentes
    conexion_rom:ROM 
        port map(
            addr => add_rom,
            --salida 32 bits: 5 bits hacia mux de lectura de registro RA
            data_o(19 downto 15) => to_mux_RA,
            --salida 32 bits: 5 bits hacia mux de lectura de registro RB
            data_o(24 downto 20) => to_mux_RB,
            --salida 32 bits: 5 bits hacia direccion de registro de escritura rd
            data_o(11 downto 7) => to_banco_add,
            
            data_o(6 downto 0) => to_code_operation,
            data_o(14 downto 12) => al_func3,
            data_o(31 downto 25) => to_7b
               );
      
      conexion_demux:DEMUX_32X1 
      port map(
        entrada => to_banco_add,
        salida  => to_banco_addvector32
      );         
                 
     conexion_banco_registros:  BancoRegistros
        port map(
            clk => clk, 
            rst => rst,
            adr => to_banco_addvector32,
            d => senial_d_from_mux2_out,
            q => senial_d_to_muxes,
            r_we => ctr_r_we
        );  
        
     conexion_mux32x1_RA:  MUX_32X1
                port map(
                    entrada => senial_d_to_muxes, 
                    sel => to_mux_RA,
                    salida => senial_muxRA_to_alu
                );   
                 
     conexion_mux32x1_RB:  MUX_32X1
        port map(
            entrada => senial_d_to_muxes, 
            sel => to_mux_RB,
            salida => senial_muxRB_to_alu
         ); 
     
     conexion_alu:  ALU  
     port map(
        a => senial_muxRA_to_alu,
        b => senial_mux2x1_to_alu,
        s => senial_selector_to_alu,--** hacer señal de alu de 5 bits para todas las operaciones
        c_in=> '0',
        --c_out=>,
        z=> senial_alu_to_m2_in
     );
     
     conexion_pc:  PCounter  
          port map(
            clk => clk,
            rst =>rst,
            we =>'1',
            pc_in => signal_mux_suma_to_pc_counter,
            pc_out => add_rom 
          );
      
      conexion_control:  Control
      port map(
        opcode => to_code_operation,
        rst =>rst,
        ctr_alu =>ctr_to_alu,
        jump => ctr_jump,
        m_rd => ctr_to_rd_data,
        m_wr => ctr_to_wr_data,
        reg_dst => ctr_to_reg_dst,
        r_wr => ctr_r_we,
        alu_src => ctr_alu_source
     );   
     
     conexion_mux:  MUX_2X1
           port map(
             a => senial_muxRB_to_alu,
             b => al_extensor,
             sel =>ctr_alu_source,
             z => senial_mux2x1_to_alu
          );   
          
    conexion_actl:  ALU_CONTROL
                     port map(
                       tipo_inst => ctr_to_alu,
                       func3 => al_func3,
                       func12 => to_12b,
                       rst => rst,
                       ope_out => senial_selector_to_alu
                    );
    
    --conexion_ram:  RAM_32X8
    --                port map(
    --                   addr => senial_alu_to_m2_in  ,
    --                   we => ctr_to_wr_data,
    --                   clk => clk,
    --                   rst => rst,
    --                   data_i => senial_muxRB_to_alu,
    --                   data_o => senial_mem_p_to_m2
    --                   ); 
    
    conexion_mux_m2:  MUX_2X1
        port map(
            a => senial_alu_to_m2_in,
            b => senial_mem_p_to_m2,
            sel =>ctr_to_reg_dst,
            z => senial_d_from_mux2_out
            ); 
 
--------and para activar el mux de salto
al_and_out <= ctr_jump and senial_alu_to_m2_in(0);  

conexion_mux_salto:  MUX_2X1
           port map(
             a => x"00000000",
             b => al_extensor_31_25_y_11_7,
             sel =>al_and_out,
             z => senial_mux2x1_salto_out_to_mux_suma_in
          );          
          
-------mux de suma para salto en pc counter      
conexion_mux_su:  MUX_2X1
                     port map(
                       a => x"00000001",
                       b => senial_mux2x1_salto_out_to_mux_suma_in,
                       sel =>al_and_out,
                       z => signal_mux_suma_to_pc_counter
                    );         
   --salida de memoria de datos para cache 
   --direccion desde risc  hacia cache             
   adreess_to_cache <= senial_alu_to_m2_in;
   --write enable para habilitar escritura en memoria de datos
   --primero se buscara en cache si esta ya no va a memoria de datos
   --si no esta escribe en memoria de datos y en cache
   we_to_cache <= ctr_to_wr_data;
   --data desde riscc  hacia cache
   data_from_rb_to_cache <= senial_muxRB_to_alu;
   --data desde cache o memeoria de datos hacia risc
   senial_mem_p_to_m2<= data_from_cache_to_m2;
end Behavioral;
