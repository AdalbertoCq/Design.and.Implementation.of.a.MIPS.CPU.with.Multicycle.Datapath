library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ALUControlUnit is 
  port( ALUOp: in std_logic_vector(1 downto 0);
        Ff:    in std_logic_vector(5 downto 0);
        Oper:  out std_logic_vector(2 downto 0)
      );
      
    end ALUControlUnit;
    
architecture behave of ALUControlUnit is
begin
  
  process(ALUOp,Ff)
  begin
     
        Oper(2) <= ( ALUOp(0) or ( ALUOp(1)and Ff(1)));
        Oper(1) <= ( not(ALUOp(1)) or not(Ff(2)));
        Oper(0) <= (( ALUOp(1) )and( Ff(3) or Ff(0)));
      
    end process;
    
  end behave;
  