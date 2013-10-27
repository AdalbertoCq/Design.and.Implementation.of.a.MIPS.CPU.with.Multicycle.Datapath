library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bits5reg is 
    port (
	      data5  :in  std_logic_vector(4 downto 0);
        clk   :in  bit;
        q5     :out std_logic_vector(4 downto 0)
	);
end entity;

architecture behavior of bits5reg is 

begin
    process (clk) begin
	    if (clk='1' and clk'event) then 
		    q5 <= data5;
		end if;
	end process;

end architecture;
 
