library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity instructionRegister is 
    port(
        IRWrite     : in  std_logic;
        instrucInput : in  std_logic_vector(31 downto 0);
	     	opCode      : out std_logic_vector(5 downto 0);
        regRs	    : out std_logic_vector(4 downto 0);
		    regRt   	: out std_logic_vector(4 downto 0);
		    regRd   	: out std_logic_vector(4 downto 0);
		    imm         : out std_logic_vector(15 downto 0);
		    jumpAddr    : out std_logic_vector(25 downto 0);
		    funcCode    : out std_logic_vector(5 downto 0)
          );
end entity;

architecture behavior of instructionRegister is

    signal addr_Output1 : std_logic_vector(5 downto 0);
   	signal addr_Output2 : std_logic_vector(4 downto 0);
	  signal addr_Output3 : std_logic_vector(4 downto 0);
	  signal addr_Output4 : std_logic_vector(4 downto 0);
   	signal addr_Output5 : std_logic_vector(15 downto 0);
	  signal addr_Output6 : std_logic_vector(25 downto 0);
	  signal addr_Output7 : std_logic_vector(5 downto 0);

begin
    
	opCode   <= addr_Output1;
	regRs    <= addr_Output2;
	regRt    <= addr_Output3;
	regRd    <= addr_Output4;
	imm      <= addr_Output5;
  jumpAddr <= addr_Output6;
	funcCode <= addr_Output7;
	
    process (IRWrite , instrucInput) begin
        if( IRWrite  = '1' ) then 
            addr_Output1 <= instrucInput(31 downto 26);
			      addr_Output2 <= instrucInput(25 downto 21);
			      addr_Output3 <= instrucInput(20 downto 16);
			      addr_Output4 <= instrucInput(15 downto 11);
			      addr_Output5 <= instrucInput(15 downto 0);
			      addr_Output6 <= instrucInput(25 downto 0);
			      addr_Output7 <= instrucInput(5 downto 0);
        end if;
	end process;
	
end architecture;
	