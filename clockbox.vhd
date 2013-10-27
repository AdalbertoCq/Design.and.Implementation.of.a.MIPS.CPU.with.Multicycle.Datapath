library ieee;
      use ieee.std_logic_1164.all;
      use ieee.std_logic_unsigned.all;
      use ieee.std_logic_arith.all;

entity clockbox is 
    port (clk: inout bit);
    end clockbox;
    
architecture behavioral of clockbox is
    begin 
        process
          begin 
            clk <= not(clk);
            wait for 100 ns;
        end process;
        
end behavioral;
    