library ieee;
      use ieee.std_logic_1164.all;

entity mux2 is 
  generic ( delay: time:=2 ns );
  port  (e0,e1: in std_logic_vector (31 downto 0);
          C: in std_logic;
          s: out std_logic_vector (31 downto 0));
end mux2;

architecture behavioral of mux2 is 
  begin 
    with (C) select
      
       s <= e0 when '0',
            e1 when others;
            
end behavioral; 
          


