library ieee;
      use ieee.std_logic_1164.all;
      use ieee.std_logic_unsigned.all;
      use ieee.std_logic_arith.all;
      
entity CUnit is 
  generic ( delay: time:=2 ns );
  port  (OPC: in std_logic_vector (5 downto 0);--input of the Operation code
         CS: in std_logic_vector (3 downto 0);-- input of the current state
         ALUOp: out std_logic_vector (1 downto 0);--output to the ALUControl 
         ALUSrcB: out std_logic_vector (1 downto 0);--output to the mux4 of the ALU
         ALUSrcA: out std_logic;-- output to mux2 of the ALU
         PCSource: out std_logic_vector (1 downto 0); --goes to mux4 before of the PC
         PCWriteCond: out std_logic; --goes to and gate with the zero signal from the ALU
         PCwrite: out std_logic; --to allow to write in PC (the jump, branch PC+4)
         IorD: out std_logic;--load/store
         MemRead: out std_logic;--read on memory
         MemWrite: out std_logic; --write in memory
         MemtoReg: out std_logic; --to the mux2 to write in the register of memory
         IRWrite: out std_logic; --it allows to load in the register the intruction
         RegDst: out std_logic; --to mux2 to write in mem register
         RegWrite: out std_logic; --to write in the memory registers
         NewS: out std_logic_vector (3 downto 0);
         Branchsignal: out std_logic);--new states
         

end CUnit;
          
architecture behavioral of CUnit is 
    begin
      process (OPC, CS)
        begin
         PCwrite <= ((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(not(CS(0))))or((CS(3))and(not(CS(2)))and(not(CS(1)))and(CS(0)));
         PCWriteCond <= ((CS(3))and(not(CS(2)))and(not(CS(1)))and(not(CS(0))));
         MemRead <= (((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(not(CS(0)))) or ((not(CS(3)))and(not(CS(2)))and(CS(1))and(CS(0))));
         MemWrite <= ((not(CS(3)))and(CS(2))and(not(CS(1)))and(CS(0)));
         IorD<= (((not(CS(3)))and(CS(2))and(not(CS(1)))and(CS(0))) or ((not(CS(3)))and(not(CS(2)))and(CS(1))and(CS(0))));
         IRWrite <= ((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(not(CS(0))));
         MemtoReg <= ((not(CS(3)))and(CS(2))and(not(CS(1)))and(not(CS(0))));
         PCSource(1)<= ((CS(3))and(not(CS(2)))and(not(CS(1)))and(CS(0)));
         PCSource(0)<= ((CS(3))and(not(CS(2)))and(not(CS(1)))and(not(CS(0))));
         ALUOp(1) <= ((not(CS(3)))and(CS(2))and(CS(1))and(not(CS(0))));
         ALUOp(0) <= ((CS(3))and(not(CS(2)))and(not(CS(1)))and(not(CS(0))));
         ALUSrcB(1) <= (((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(CS(0))) or ((not(CS(3)))and(not(CS(2)))and(CS(1))and(not(CS(0)))));
         ALUSrcB(0) <= (((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(CS(0))) or ((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(not(CS(0)))));
         ALUSrcA <= (((not(CS(3)))and(not(CS(2)))and(CS(1))and(not(CS(0)))) or (((not(CS(3)))and(CS(2))and(CS(1))and(not(CS(0))))) or ((CS(3))and(not(CS(2)))and(not(CS(1)))and(not(CS(0)))));
         RegWrite <= (((not(CS(3)))and(CS(2))and(not(CS(1)))and(not(CS(0)))) or (((not(CS(3)))and(CS(2))and(CS(1))and(CS(0)))));
         RegDst <= ((not(CS(3)))and(CS(2))and(CS(1))and(CS(0)));
       case (OPC) is
         when "000100" => Branchsignal <='0';
         when others => Branchsignal <='1';
       end case;
       
         --Next States:
                                                                   
         NewS(0) <= (((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(not(CS(0)))) or 
                  ((not(CS(3)))and(not(CS(2)))and(CS(1))and(not(CS(0))) and (OPC(5))and(not(OPC(4)))and(not(OPC(3)))and(not(OPC(2)))and(OPC(1))and(OPC(0))) or
                  ((not(CS(3)))and(not(CS(2)))and(CS(1))and(not(CS(0))) and (OPC(5))and(not(OPC(4)))and(OPC(3))and(not(OPC(2)))and(OPC(1))and(OPC(0))) or
                  ((not(CS(3)))and(CS(2))and(CS(1))and(not(CS(0)))) or 
                  ((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(CS(0))and(not(OPC(5)))and(not(OPC(4)))and(not(OPC(3)))and(not(OPC(2)))and(OPC(1))and(not(OPC(0))))) ;
         NewS(1) <= (((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(CS(0))and((OPC(5))and(not(OPC(4)))and(OPC(3))and(not(OPC(2)))and(OPC(1))and(OPC(0)) ) )or 
                  (((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(CS(0))and((OPC(5))and(not(OPC(4)))and(not(OPC(3)))and(not(OPC(2)))and(OPC(1))and(OPC(0)) ) )or
                  ((not(CS(3)))and(not(CS(2)))and(CS(1))and(not(CS(0)))and(OPC(5))and(not(OPC(4)))and(not(OPC(3)))and(not(OPC(2)))and(OPC(1))and(OPC(0)))or
                  ((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(CS(0))and(not(OPC(5)))and(not(OPC(4)))and(not(OPC(3)))and(not(OPC(2)))and(not(OPC(1)))and(not(OPC(0))))
                  or ((not(CS(3)))and(CS(2))and(CS(1))and(not(CS(0))))));
         NewS(2) <= (((not(CS(3)))and(not(CS(2)))and(CS(1))and(CS(0))) or 
                  ((not(CS(3)))and(not(CS(2)))and(CS(1))and(not(CS(0)))and(OPC(5))and(not(OPC(4)))and(OPC(3))and(not(OPC(2)))and(OPC(1))and(OPC(0)))or
                  ((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(CS(0))and(not(OPC(5)))and(not(OPC(4)))and(not(OPC(3)))and(not(OPC(2)))and(not(OPC(1)))and(not(OPC(0)))) or
                  ((not(CS(3)))and(CS(2))and(CS(1))and(not(CS(0))) ) );
         NewS(3) <= (((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(CS(0))and(not(OPC(5)))and(not(OPC(4)))and(not(OPC(3)))and(OPC(2))and(not(OPC(1)))and(not(OPC(0)))) 
                  or ((not(CS(3)))and(not(CS(2)))and(not(CS(1)))and(CS(0))and(not(OPC(5)))and(not(OPC(4)))and(not(OPC(3)))and(not(OPC(2)))and(OPC(1))and(not(OPC(0)))));

      end process;

end behavioral;


