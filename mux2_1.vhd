library ieee;
      use ieee.std_logic_1164.all;

entity mux2_1 is 
  generic ( delay: time:=2 ns );
  port  (e0,e1: in std_logic;
          C: in std_logic;
          s: out std_logic);
end mux2_1;

architecture behavioral of mux2_1 is 
  begin 
    with (C) select
      
       s <= e0 when '0',
            e1 when others;
            
end behavioral; 
          




