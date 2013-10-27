library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity signExtend is 
    port(
	    dataIn  :in  std_logic_vector(15 downto 0);
		dataOut :out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavior of signExtend is 

	begin
        process(dataIn) begin 
		    if( dataIn(15)='1') then
			    dataOut(15 downto 0)  <= dataIn(15 downto 0);
				dataOut(31 downto 16) <= "1111111111111111";
			else 
			    dataOut(15 downto 0)  <= dataIn(15 downto 0);
				dataOut(31 downto 16) <= "0000000000000000";
			end if;
		end process;
end architecture;
