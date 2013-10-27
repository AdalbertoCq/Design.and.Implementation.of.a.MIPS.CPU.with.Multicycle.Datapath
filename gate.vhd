library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity gate2 is 
    port (
	    a :in  std_logic;
    		b :in  std_logic;
		  y :out std_logic
	);
end entity;
		
architecture behavior of gate2 is 

begin
    process(a,b) begin
	    y <= ((a) and (b));
	end process;
	
end architecture;
