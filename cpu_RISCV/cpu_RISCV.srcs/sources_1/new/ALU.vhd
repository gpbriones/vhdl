----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2023 03:17:14
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    generic(
          n:integer :=32
      );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           s : in STD_LOGIC_VECTOR (5 downto 0);
           c_in : in STD_LOGIC;
           c_out : out STD_LOGIC;
           z : out STD_LOGIC_VECTOR (n-1 downto 0));
end ALU;

architecture Behavioral of ALU is

--Componente UL unidad logica
----------------------------------------------------------
component CI_32bits is
     generic(
      n:integer :=32
  );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           z : out STD_LOGIC_VECTOR (n-1 downto 0);
           s : in STD_LOGIC_VECTOR (1 downto 0));
end component CI_32bits;

--Componente UA unidad aritmetica
--------------------------------------------------------------------
component UA is
    generic(
      n:integer :=32
  );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           s : in STD_LOGIC_VECTOR (1 downto 0);
           c_in : in STD_LOGIC;
           za : out STD_LOGIC_VECTOR (n-1 downto 0);
           c_out : out STD_LOGIC);
end component UA;


--Componente mux de n bits
-----------------------------------------------------------
component MUX_5X1_32 is
     generic(
     n:integer :=32
    );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           c : in STD_LOGIC_VECTOR (n-1 downto 0);
           d : in STD_LOGIC_VECTOR (n-1 downto 0);
           e : in STD_LOGIC_VECTOR (n-1 downto 0);
           f : in STD_LOGIC_VECTOR (n-1 downto 0);
           sel : in STD_LOGIC_VECTOR (2 downto 0);
           z : out STD_LOGIC_VECTOR (n-1 downto 0));
end component MUX_5X1_32;

--desplazamientos
-------------------------------------------------------
component UShifts is
    generic(
      n:integer :=32
  );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           s : in STD_LOGIC_VECTOR (2 downto 0);
           zUS : out STD_LOGIC_VECTOR (n-1 downto 0)
           );
end component UShifts;

--saltos
-------------------------------------------------------
component U_Branches is
    generic(
      n:integer :=32
  );
    Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
           b : in STD_LOGIC_VECTOR (n-1 downto 0);
           s : in STD_LOGIC_VECTOR (2 downto 0);
           zUB : out STD_LOGIC_VECTOR (n-1 downto 0)
           );
end component U_Branches;

    signal al_zl    : STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_za    : STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_zus   : STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_comp  : STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_branch: STD_LOGIC_VECTOR (n-1 downto 0);
    signal al_jump  : STD_LOGIC_VECTOR (n-1 downto 0);

begin
    
    --mapeo de componente Unidad Logica
    u_l:CI_32bits 
        port map(
              a => a,
              b => b,
              z => al_zl,
              s => s(1 downto 0)
               );
     --mapeo de componente Unidad Aritmetica
     u_a:UA 
        port map(
            a => a,
            b => b,
            za => al_za,
            s => s(1 downto 0),
            c_in =>'0'
            --c_out =>
            );
            
     --mapeo de unidad de desplazamientos
      U_Shifts: UShifts
         port map ( 
             a => a,
             b => b,
             s =>  s(2 downto 0),
             zUS => al_zus
             );


 --mapeo de unidad de saltos
     U_saltos: U_Branches
        port map ( 
            a => a,
            b => b,
            s =>  s(2 downto 0),
            zUB => al_branch
            );
            
--mapeo de componente mux n bits
-----------------------------------------------
    mux_5x1: MUX_5X1_32 
       port map(
                        a => al_za,
                        b => al_zl,
                        c => al_zus,
                        d => al_comp,
                        e => al_branch,
                        f => al_jump,
                        sel => s(4 downto 2),
                        z => z
                         ); 
        ------------------------------------------------
    
end Behavioral;
