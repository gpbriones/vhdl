----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2023 18:21:13
-- Design Name: 
-- Module Name: PipeLine4FA4B - Behavioral
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

entity PipeLine4FA4B is
     generic(
     -- se crearan 4 sumadores completos de 4 bits cada uno, 
     --con pipeline
      n:integer :=16
  );
   Port ( Ap : in STD_LOGIC_VECTOR (n-1 downto 0);
          Bp : in STD_LOGIC_VECTOR (n-1 downto 0);
          Cp_in : in STD_LOGIC;
          clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          Cp_out : out STD_LOGIC;
          Sp : out STD_LOGIC_VECTOR (n-1 downto 0));
end PipeLine4FA4B;

architecture Behavioral of PipeLine4FA4B is
    --componente Sumador Completo 4 bits
    component FullAdder_4Bits is
         generic(
           n:integer :=4
       );
        Port ( a : in STD_LOGIC_VECTOR (n-1 downto 0);
               b : in STD_LOGIC_VECTOR (n-1 downto 0);
               c_in : in STD_LOGIC;
               c_out : out STD_LOGIC;
               s : out STD_LOGIC_VECTOR (n-1 downto 0));
    end component FullAdder_4Bits;
    
    --componente registro 4 bits
    component flipFlop_D is
        generic(
           n:integer :=4
       );
        Port ( d: in STD_LOGIC_VECTOR (n-1 downto 0);
               clk: in STD_LOGIC;
               q : inout STD_LOGIC_VECTOR (n-1 downto 0));
    end component flipFlop_D;
    
    --componente registro 1 Bit
    component Registro1B is
        Port ( d: in STD_LOGIC;
               clk: in STD_LOGIC;
               q : inout STD_LOGIC );
    end component Registro1B;
    
    signal a_n1 : STD_LOGIC_VECTOR (n downto 0):= (others => '0');
    signal a_n2 : STD_LOGIC_VECTOR (n downto 0):= (others => '0');
    signal a_n3 : STD_LOGIC_VECTOR (n downto 0):= (others => '0');
    
    signal b_n1 : STD_LOGIC_VECTOR (n downto 0):= (others => '0'); 
    signal b_n2 : STD_LOGIC_VECTOR (n downto 0):= (others => '0'); 
    signal b_n3 : STD_LOGIC_VECTOR (n downto 0):= (others => '0'); 
    
    signal s_n : STD_LOGIC_VECTOR (n downto 0):= (others => '0');  
    signal s_f : STD_LOGIC_VECTOR (n-1 downto 0):= (others => '0');  
    
    signal co_1 : STD_LOGIC;  
    signal ci_1 : STD_LOGIC; 
    
    signal co_2 : STD_LOGIC;  
    signal ci_2 : STD_LOGIC; 
        
    signal co_3 : STD_LOGIC;  
    signal ci_3 : STD_LOGIC;  
begin
    --mapeo de purtos
        -- registro para A4-A7
        R4b_1:flipFlop_D 
        port map(
            d => Ap(7 downto 4),
            clk => clk,
            q => a_n1(7 downto 4)
            );
        -- registro para B4-B7
        R4b_2:flipFlop_D 
        port map(
            d => Bp(7 downto 4),
            clk => clk,
            q => b_n1(7 downto 4)
            ); 
            
        -- registro para A8-A11
        R4b_3:flipFlop_D 
        port map(
           d => Ap(11 downto 8),
           clk => clk,
           q => a_n1(11 downto 8)
           );
         -- registro para B8-B11
         R4b_4:flipFlop_D 
         port map(
            d => Bp(11 downto 8),
            clk => clk,
            q => b_n1(11 downto 8)
            );        
                        
        -- registro para A12-A15
        R4b_5:flipFlop_D 
        port map(
            d => Ap(15 downto 12),
            clk => clk,
            q => a_n1(15 downto 12)
            );
        
        -- registro para B12-B15
        R4b_6:flipFlop_D 
         port map(
             d => Bp(15 downto 12),
             clk => clk,
             q => b_n1(15 downto 12)
             );  
             
        FA4B_1:FullAdder_4Bits 
            port map(
                 a => Ap(3 downto 0),
                 b => Bp(3 downto 0),
                 c_in => '0',
                 c_out => co_1,
                 s => s_n(3 downto 0)
                 ); 

        R1b_c1:Registro1B 
        port map(
            d => co_1,
            clk => clk,
            q => ci_1
            );                
        --
        --nivel 2 de pipeline
        --                   
        -- registro para A4-A7
        R4b_7:flipFlop_D 
        port map(
            d => s_n(3 downto 0),
            clk => clk,
            q => a_n2(3 downto 0)
            );
 
        FA4B_2:FullAdder_4Bits  
        port map(
            a => a_n1(7 downto 4),
            b => b_n1(7 downto 4),
            c_in => ci_1,
            c_out => co_2,
            s => s_n(7 downto 4)
            );              
            
            
         -- registro para A8-A11
         R4b_8:flipFlop_D 
            port map(
                d => a_n1(11 downto 8),
                clk => clk,
                q => a_n2(11 downto 8)
               );
         -- registro para B8-B11
         R4b_9:flipFlop_D 
            port map(
                d => b_n1(11 downto 8),
                clk => clk,
                q => b_n2(11 downto 8)
                );        
                                
         -- registro para A12-A15
         R4b_10:flipFlop_D 
            port map(
                d => a_n1(15 downto 12),
                clk => clk,
                q => a_n2(15 downto 12)
                );
                
         -- registro para B12-B15
         R4b_11:flipFlop_D 
         port map(
              d => b_n1(15 downto 12),
              clk => clk,
              q => b_n2(15 downto 12)
        );  
                       
        
        
        --
        --nivel 3 de pipeline
        --                   
        -- registro para A4-A7
        R4b_12:flipFlop_D 
        port map(
           d => a_n2(3 downto 0),
           clk => clk,
           q => a_n3(3 downto 0)
           );
         
       R4b_13:flipFlop_D 
                   port map(
                      d => s_n(7 downto 4),
                      clk => clk,
                      q => a_n3(7 downto 4)
                      );              

        R1b_c2:Registro1B 
            port map(
                d => co_2,
                clk => clk,
                q => ci_2
            );                    
                  
        FA4B_3:FullAdder_4Bits  
            port map(
                   a => a_n2(11 downto 8),
                   b => b_n2(11 downto 8),
                   c_in => ci_2,
                   c_out => co_3,
                   s => s_n(11 downto 8)
                    );
                                        
                 -- registro para A12-A15
                 R4b_14:flipFlop_D 
                    port map(
                        d => a_n2(15 downto 12),
                        clk => clk,
                        q => a_n3(15 downto 12)
                        );
                        
                 -- registro para B12-B15
                 R4b_15:flipFlop_D 
                 port map(
                      d => b_n2(15 downto 12),
                      clk => clk,
                      q => b_n3(15 downto 12)
                );             
                  
                  
                  --
                  --nivel 4 de pipeline
                  --                   
                  -- registro para A4-A7
                  R4b_16:flipFlop_D 
                        port map(
                           d => a_n3(3 downto 0),
                           clk => clk,
                           q => s_f(3 downto 0)
                           );
                         
                  R4b_17:flipFlop_D 
                       port map(
                          d => a_n3(7 downto 4),
                          clk => clk,
                          q => s_f(7 downto 4)
                          );
                          
                  R4b_18:flipFlop_D 
                        port map(
                           d => s_n(11 downto 8),
                           clk => clk,
                           q => s_f(11 downto 8)
                            );                                                                          
                
                  R1b_c3:Registro1B 
                            port map(
                                d => co_3,
                                clk => clk,
                                q => ci_3
                            );                    
                                     
             FA4B_4:FullAdder_4Bits 
               port map(
               a => a_n3(15 downto 12),
               b => b_n3(15 downto 12),
               c_in => ci_3,
               c_out => Cp_out,
               s =>s_f(15 downto 12)
               );
               
               Sp <=s_f;
    

end Behavioral;
