library ieee;
      use ieee.std_logic_1164.all;

entity mux4 is 
  generic ( delay: time:=2 ns );
  port  (e0,e1,e2,e3: in std_logic_vector (31 downto 0);
          C: in std_logic_vector (1 downto 0);
          s: out std_logic_vector (31 downto 0));
end mux4;

architecture behavioral of mux4 is 
  begin 
    with (C) select
       s <= e0 when "00",
            e1 when "01",
            e2 when "10",
            e3 when others;
            
end behavioral; 
          
