library ieee;
      use ieee.std_logic_1164.all;

entity mux2_5b is 
  port  (e0,e1: in std_logic_vector (4 downto 0);
          C: in std_logic;
          s: out std_logic_vector (4 downto 0));
end mux2_5b;

architecture behavioral of mux2_5b is 
  begin 
    with (C) select
      
       s <= e0 when '0',
            e1 when others;
            
end behavioral; 
