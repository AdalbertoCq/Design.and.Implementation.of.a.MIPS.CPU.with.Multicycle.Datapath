library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc is 
    port(
        writeEnable : in  std_logic;
        addrInput   : in  std_logic_vector(31 downto 0);
        addrOutput	: out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavior of pc is

    signal addr_Output : std_logic_vector(31 downto 0);

begin
    
	addrOutput <= addr_Output;
	
    process (writeEnable, addrInput) begin
        if( writeEnable = '1' ) then 
            addr_Output <= addrInput after 10 ns;
        end if;
	end process;
end architecture;