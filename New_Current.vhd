library ieee;
      use ieee.std_logic_1164.all;
      use ieee.std_logic_unsigned.all;
      use ieee.std_logic_arith.all;

entity New_Current is
  port (NewS: in std_logic_vector (3 downto 0);--New states taht are going to be load
        clk: in bit;
        CS: out std_logic_vector (3 downto 0));--output of the block
      
    end New_Current;

architecture behavioral of New_Current is
  begin
      process (NewS, clk)
        begin 
          --clock rising edge
          if (clk='1' and clk'event) then
              CS <= NewS;
            end if;
          
        end process;
end behavioral;
          