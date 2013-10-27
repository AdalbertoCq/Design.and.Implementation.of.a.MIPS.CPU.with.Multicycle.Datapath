library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity registers is generic ( DATA_WIDTH :integer := 32; ADDR_WIDTH :integer := 5 );

    port(
        address1 : in std_logic_vector(ADDR_WIDTH-1 downto 0); --address Input read register rs
        address2 : in std_logic_vector(ADDR_WIDTH-1 downto 0); --address Input read register rt
        address3 : in std_logic_vector(ADDR_WIDTH-1 downto 0); --address Input write resister rd
        data1    : out std_logic_vector(DATA_WIDTH-1 downto 0); --data Output rs
        data2    : out std_logic_vector(DATA_WIDTH-1 downto 0); --data output rt
        data3    : in std_logic_vector(DATA_WIDTH-1 downto 0); --data Input 
        RegWrite       : in std_logic
        ); 
end entity;
      
architecture rtl of registers is 

    --Internal Variables--
    constant RAM_DEPTH :integer := 2**ADDR_WIDTH;
     
    signal data_out1 : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal data_out2 : std_logic_vector(DATA_WIDTH-1 downto 0);
     
    type RAM is array (integer range<>)of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal mem : RAM (0 to RAM_DEPTH-1);
     
begin
  
    data1 <= data_out1; 
    data2 <= data_out2; 
  
    --Memory Write Block 
    MEM_WRITE:
    process (address3, data3, RegWrite) begin
        if(RegWrite ='1') then 
            mem( conv_integer(address3))<=data3;
        end if;
    end process;   
  
    MEM_READ: 
    process (address1, address2, RegWrite) begin
        data_out1 <= mem( conv_integer(address1));
        data_out2 <= mem( conv_integer(address2));
    end process;
  
end architecture;
