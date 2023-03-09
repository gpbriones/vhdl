------------------------
--Descripcion: Entrega CPU Basada En RISCV con PIPELINE
--Arquitectura de Computadoras
--Gustavo Perez Briones
-------------------------
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
    clk, rst : in STD_LOGIC);
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

--------------------------------------
--componente IF/ID (IstructionFetch/Instruction Decoder)
--Es un registro para separar la parte de la ROM dde instrucciones con la 
--decodificacion de estas.
--------------------------------------- 
component IF_ID is
    generic(
       n:integer :=32
   );
    Port ( d: in STD_LOGIC_VECTOR (n-1 downto 0);
           clk: in STD_LOGIC;
           we: in STD_LOGIC;
           rst: in STD_LOGIC;
           q : inout STD_LOGIC_VECTOR (n-1 downto 0));
end component IF_ID;

 
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


--------------------------------------
--componente ID/EX (Istruction Decoder/Execute)
--Es un registro para separar la parte Registros y muxes 32x1, con ALU.
--------------------------------------- 
component ID_EX is
    generic(
       n:integer :=151
   );
    Port ( d: in STD_LOGIC_VECTOR (n-1 downto 0);
           clk: in STD_LOGIC;
           we: in STD_LOGIC;
           rst: in STD_LOGIC;
           q : inout STD_LOGIC_VECTOR (n-1 downto 0));
end component ID_EX;



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



--------------------------------------
--componente EX/MEM (Istruction Execute/Memoria)
--Es un registro para separar la parte Execute y de memoria
--------------------------------------- 
component EX_MEM is
    generic(
       n:integer :=132
   );
    Port ( we, clk, rst: in std_logic;
           d : in STD_LOGIC_VECTOR (n-1 downto 0);
           q : inout STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0'));
end component EX_MEM;



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

--------------------------------------
--componente EX/MEM (Istruction Execute/Memoria)
--Es un registro para separar la parte Execute y de memoria
--------------------------------------- 
component MEM_WB is
    generic(
       n:integer :=65
   );
    Port ( we, clk, rst: in std_logic;
           d : in STD_LOGIC_VECTOR (n-1 downto 0);
           q : inout STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0'));
end component MEM_WB;


---------------------------------------
---seniales
---------------------------------------
    signal add_rom: STD_LOGIC_VECTOR (31 downto 0);
    signal to_mux_RA: STD_LOGIC_VECTOR (4 downto 0);
    signal to_mux_RB: STD_LOGIC_VECTOR (4 downto 0);
    signal to_banco_add: STD_LOGIC_VECTOR (4 downto 0);
    signal to_banco_addvector32: STD_LOGIC_VECTOR (n-1 downto 0);
    
    --señales para pipeline IF/ID
    signal to_mux_RA_IFID: STD_LOGIC_VECTOR (4 downto 0);
    signal to_mux_RB_IFID: STD_LOGIC_VECTOR (4 downto 0);
    signal to_banco_add_IFID: STD_LOGIC_VECTOR (4 downto 0);
    signal to_code_operation_IFID: STD_LOGIC_VECTOR (6 downto 0);
    signal al_func3_IFID: STD_LOGIC_VECTOR (2 downto 0);
    signal al_func3_IDEX: STD_LOGIC_VECTOR (2 downto 0);
    signal to_7b_IFID: STD_LOGIC_VECTOR (6 downto 0);
    
    
    signal senial_d_from_mux2_out: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_alu_to_m2_in: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_alu_to_m2_in_EXMEM: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_alu_to_m2_in_MEM_WB: STD_LOGIC_VECTOR (n-1 downto 0);
    
    signal senial_d_to_muxes: STD_LOGIC_VECTOR ((n*n)-1 downto 0);
    
    signal senial_muxRA_to_alu: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_muxRA_to_alu_IDEX: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_muxRB_to_alu: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_muxRB_to_alu_IDEX: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_muxRB_to_alu_EXMEM: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_mux2x1_to_alu: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_mem_p_to_m2: STD_LOGIC_VECTOR (n-1 downto 0);
    signal senial_mem_p_to_m2_MEM_WB: STD_LOGIC_VECTOR (n-1 downto 0);
    
    
    signal senial_selector_to_alu: STD_LOGIC_VECTOR (5 downto 0);
    
    signal to_code_operation: STD_LOGIC_VECTOR (6 downto 0);
    signal al_func3: STD_LOGIC_VECTOR (2 downto 0);
    signal to_12b: STD_LOGIC_VECTOR (11 downto 0);
    signal to_12b_IDEX: STD_LOGIC_VECTOR (11 downto 0);
    signal to_7b: STD_LOGIC_VECTOR (6 downto 0);
    
    --seniales de control:
    --senial de control para habilitar/deshabilitar banco de registros
    signal ctr_r_we: STD_LOGIC;
    --signal ctr_r_we_IDEX: STD_LOGIC;
    signal ctr_to_rd_data: STD_LOGIC;
    signal ctr_to_rd_data_IDEX: STD_LOGIC;
    signal ctr_to_rd_data_EXMEM: STD_LOGIC;
    signal ctr_to_wr_data: STD_LOGIC;
    signal ctr_to_wr_data_IDEX: STD_LOGIC;
    signal ctr_to_wr_data_EXMEM: STD_LOGIC;
    signal ctr_to_alu: STD_LOGIC_VECTOR (2 downto 0);
    signal ctr_to_alu_IDEX: STD_LOGIC_VECTOR (2 downto 0);
    signal ctr_alu_source: STD_LOGIC;
    signal ctr_alu_source_IDEX: STD_LOGIC;
    signal ctr_to_reg_dst: STD_LOGIC;
    signal ctr_to_reg_dst_IDEX: STD_LOGIC;
    signal ctr_to_reg_dst_EXMEM: STD_LOGIC;
    signal ctr_to_reg_dst_MEM_WB: STD_LOGIC;
    signal ctr_jump: STD_LOGIC;
    signal ctr_jump_IDEX: STD_LOGIC;
    signal ctr_jump_EXMEM: STD_LOGIC;
    
    --senial extensor de bits
    signal al_extensor: STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_extensor_IDEX: STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_extensor_EXMEM: STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_extensor_31_25_y_11_7: STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_extensor_31_25_y_11_7_IDEX: STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_extensor_31_25_y_11_7_EXMEM: STD_LOGIC_VECTOR (n-1 downto 0);
    
    
    signal senial_mux2x1_salto_out_to_mux_suma_in: STD_LOGIC_VECTOR (n-1 downto 0);
    signal signal_mux_suma_to_pc_counter: STD_LOGIC_VECTOR (n-1 downto 0);
    
    
    
    --senial de salida de alu
    signal al_and_out: STD_LOGIC;
begin

    ---extensor de bits para operaciones inmediatas:
    al_extensor <= x"00000"&to_7b_IFID&to_mux_RB_IFID;
    --funcion de 12 bits
    to_12b <= to_7b_IFID&to_mux_RB_IFID;
    --R <= std_logic_vector(to_signed(to_integer(signed(X) / signed(Y)),32));
    --extensor para salto
    --con divisor entre 4, corrimiento -->
    al_extensor_31_25_y_11_7 <= "00"&x"00000"&to_7b_IFID&to_banco_add_IFID(4 downto 2);
    --mapeo de puertos de los componentes
    -------------------------------------
    -------------------------------------
    -----------------------------------
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
     
     conexion_pc:  PCounter  
        port map(
            clk => clk,
            rst =>rst,
            we =>'1',
            pc_in => signal_mux_suma_to_pc_counter,
            pc_out => add_rom 
       );
       
     ---------------
     ---------------
     ---------------
     ---------------
     --Conexion de Pipeline estapa: IF/ID        
     pipeline_IF_ID:IF_ID
     port map(  d(6 downto 0) => to_code_operation,
                d(11 downto 7) => to_banco_add,
                d(14 downto 12) => al_func3,
                d(19 downto 15) => to_mux_RA,
                d(24 downto 20) => to_mux_RB,
                d(31 downto 25) => to_7b,
                clk => clk,
                we => '1',
                rst => rst, 
                q(6 downto 0) => to_code_operation_IFID,
                q(11 downto 7) => to_banco_add_IFID,
                q(14 downto 12) => al_func3_IFID,
                q(19 downto 15) => to_mux_RA_IFID,
                q(24 downto 20) => to_mux_RB_IFID,
                q(31 downto 25) => to_7b_IFID
             );
               
               
               
      
      conexion_demux:DEMUX_32X1 
      port map(
        entrada => to_banco_add_IFID,
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
                    sel => to_mux_RA_IFID,
                    salida => senial_muxRA_to_alu
                );   
                 
     conexion_mux32x1_RB:  MUX_32X1
        port map(
            entrada => senial_d_to_muxes, 
            sel => to_mux_RB_IFID,
            salida => senial_muxRB_to_alu
         ); 
         
     conexion_control:  Control
        port map(
            opcode => to_code_operation_IFID,
            rst =>rst,
            ctr_alu =>ctr_to_alu,
            jump => ctr_jump,
            m_rd => ctr_to_rd_data,
            m_wr => ctr_to_wr_data,
            reg_dst => ctr_to_reg_dst,
            r_wr => ctr_r_we,
            alu_src => ctr_alu_source
            );   
         
---------------
---------------
---------------
---------------
--Conexion de Pipeline estapa: Id/EX      
    pipeline_ID_EX:ID_EX
        port map(
            d(31 downto 0) =>senial_muxRA_to_alu,
            d(63 downto 32) =>senial_muxRB_to_alu,
            d(95 downto 64) =>al_extensor,
            d(127 downto 96) =>al_extensor_31_25_y_11_7,
            
            d(130 downto 128) =>ctr_to_alu,
            d(131) =>ctr_jump,
            d(132) =>ctr_to_rd_data,
            d(133) =>ctr_to_wr_data,
            d(134) =>ctr_to_reg_dst,
            d(135) =>ctr_alu_source,
            d(138 downto 136) =>al_func3_IFID,
            d(150 downto 139) =>to_12b,
            --d(151) =>ctr_r_we,
            
            clk => clk,
            we => '1',
            rst => rst,
            q(31 downto 0) =>senial_muxRA_to_alu_IDEX,
            q(63 downto 32) =>senial_muxRB_to_alu_IDEX,
            q(95 downto 64) =>al_extensor_IDEX,
            q(127 downto 96) => al_extensor_31_25_y_11_7_IDEX,
            
            q(130 downto 128) =>ctr_to_alu_IDEX,
            q(131) =>ctr_jump_IDEX,
            q(132) =>ctr_to_rd_data_IDEX,
            q(133) =>ctr_to_wr_data_IDEX,
            q(134) =>ctr_to_reg_dst_IDEX,
            
            q(135) =>ctr_alu_source_IDEX,
            q(138 downto 136) =>al_func3_IDEX,
            q(150 downto 139) =>to_12b_IDEX
            --q(151) =>ctr_r_we_IDEX
            );
     
     conexion_alu:  ALU  
     port map(
        a => senial_muxRA_to_alu_IDEX,
        b => senial_mux2x1_to_alu,
        s => senial_selector_to_alu,--** hacer señal de alu de 5 bits para todas las operaciones
        c_in=> '0',
        --c_out=>,
        z=> senial_alu_to_m2_in
     );

     conexion_mux:  MUX_2X1
           port map(
             a => senial_muxRB_to_alu_IDEX,
             b => al_extensor_IDEX,
             sel =>ctr_alu_source_IDEX,
             z => senial_mux2x1_to_alu
          );   
      
     pipeline_EX_MEM:EX_MEM
        port map(  
            d(31 downto 0) => senial_alu_to_m2_in,
            d(63 downto 32) => senial_muxRB_to_alu_IDEX,
            d(95 downto 64) => al_extensor_IDEX,
            d(127 downto 96) => al_extensor_31_25_y_11_7_IDEX,
            d(128) =>ctr_jump_IDEX,
            d(129) =>ctr_to_rd_data_IDEX,
            d(130) =>ctr_to_wr_data_IDEX,
            d(131) =>ctr_to_reg_dst_IDEX,
            
            
            clk => clk,
            we => '1',
            rst => rst, 
            
            q(31 downto 0) => senial_alu_to_m2_in_EXMEM,
            q(63 downto 32) => senial_muxRB_to_alu_EXMEM,
            q(95 downto 64) => al_extensor_EXMEM,
            q(127 downto 96) => al_extensor_31_25_y_11_7_EXMEM,
            q(128) =>ctr_jump_EXMEM,
            q(129) =>ctr_to_rd_data_EXMEM,
            q(130) =>ctr_to_wr_data_EXMEM,
            q(131) =>ctr_to_reg_dst_EXMEM
                 );     
    conexion_actl:  ALU_CONTROL
                     port map(
                       tipo_inst => ctr_to_alu_IDEX,
                       func3 => al_func3_IDEX,
                       func12 => to_12b_IDEX,
                       rst => rst,
                       ope_out => senial_selector_to_alu
                    );
    
    conexion_ram:  RAM_32X8
                    port map(
                       addr => senial_alu_to_m2_in_EXMEM,
                       we => ctr_to_wr_data_EXMEM,
                       clk => clk,
                       rst => rst,
                       data_i => senial_muxRB_to_alu_EXMEM,
                       data_o => senial_mem_p_to_m2
                       ); 


--------------------------------------
--componente EX/MEM (Istruction Execute/Memoria)
--Es un registro para separar la parte Execute y de memoria
--------------------------------------- 
pipeline_MEM_WB:MEM_WB
    port map(  
        d(31 downto 0) => senial_mem_p_to_m2,
        d(63 downto 32) => senial_alu_to_m2_in_EXMEM,
        d(64) => ctr_to_reg_dst_EXMEM,
                       
        clk => clk,
        we => '1',
        rst => rst, 
        q(31 downto 0) => senial_mem_p_to_m2_MEM_WB,
        q(63 downto 32) => senial_alu_to_m2_in_MEM_WB,
        q(64) => ctr_to_reg_dst_MEM_WB
        ); 
                                   
    conexion_mux_m2:  MUX_2X1
        port map(
            a => senial_alu_to_m2_in_MEM_WB,
            b => senial_mem_p_to_m2_MEM_WB,
            sel =>ctr_to_reg_dst_MEM_WB,
            z => senial_d_from_mux2_out
            ); 
            
            
            

            
 
--------and para activar el mux de salto
al_and_out <= ctr_jump_EXMEM and senial_alu_to_m2_in_EXMEM(0);  

conexion_mux_salto:  MUX_2X1
           port map(
             a => x"00000000",
             b => al_extensor_31_25_y_11_7_EXMEM,
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
     
end Behavioral;
