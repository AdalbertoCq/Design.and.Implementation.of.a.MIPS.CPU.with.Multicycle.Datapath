library ieee;
      use ieee.std_logic_1164.all;
      use ieee.std_logic_unsigned.all;
      use ieee.std_logic_arith.all;

entity ALU is 
  generic ( delay: time:=2 ns );
  port ( RegA: in std_logic_vector (31 downto 0);
         RegB: in std_logic_vector (31 downto 0);
         RegC: in std_logic_vector (4 downto 0);--register for the shamt; for sll instruction
         Oper: in std_logic_vector (2 downto 0);
         Result: out std_logic_vector (31 downto 0);
         Zero: out std_logic);
    end ALU;
    
architecture behavioral of ALU is
  
signal vectorsll : std_logic_vector(31 downto 0);
signal k: integer;
    begin

      process ( RegA, RegB, Oper, RegC)

        begin
          k <=conv_integer (RegC);
          case Oper is
          when "010" =>-- instruccion add
            Result<= RegA+RegB; 
          when "110" => --instruccion sub/subi
            Result<= RegA+(not(RegB))+1;
            if ((RegA+(not(RegB))+1)="00000000000000000000000000000000") then Zero<='1';
            end if;
          when "000" => --instruccion and
            Result<= ((RegA)and(RegB)); 
          when "001" => --instruccion or
            Result<= ((RegA)or(RegB));
          when "011" => --instruccion sll
              vectorsll<="00000000000000000000000000000000";
              vectorsll <= RegA(31-k downto 0) & (k-1 downto 0 => '0');
              Result <= vectorsll after 20 ns;
          when "111" =>-- instruccion slt 111
            if (RegA<RegB) then Result <= "11111111111111111111111111111111"; else 
            Result <= "00000000000000000000000000000000";
            end if;
          when others => -- instruccion nand "101"
            Result <= not(RegA and RegB);
            
          end case;
          
      end process;

end behavioral;
          
