library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity or2 is 
    port (
	    a :in  std_logic_vector(31 downto 0);
		  b :in  std_logic_vector(31 downto 0);
		  y :out std_logic_vector(31 downto 0)
	);
end entity;
		
architecture behaviour of or2 is 

begin
    process(a,b) begin
	    y <= a or b;
	end process;
	
end architecture;
