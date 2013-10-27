library ieee;
      use ieee.std_logic_1164.all;
      use ieee.std_logic_unsigned.all;
      use ieee.std_logic_arith.all;
      
entity mainFP is
  end mainFP;
  
architecture behavioral of mainFP is
  
  component New_Current 
    port (NewS: in std_logic_vector (3 downto 0);
          clk: in bit;
          CS: out std_logic_vector (3 downto 0));
        end component;
        
  component ALU
      port (RegA: in std_logic_vector (31 downto 0);
            RegB: in std_logic_vector (31 downto 0);
            RegC: in std_logic_vector (4 downto 0);
            Oper: in std_logic_vector (2 downto 0);
            Result: out std_logic_vector (31 downto 0);
            Zero: out std_logic);
    end component;
          
  component CUnit
      port  (OPC: in std_logic_vector (5 downto 0);
             CS: in std_logic_vector (3 downto 0);
             ALUOp: out std_logic_vector (1 downto 0);
             ALUSrcB: out std_logic_vector (1 downto 0);
             ALUSrcA: out std_logic;
             PCSource: out std_logic_vector (1 downto 0); 
             PCWriteCond: out std_logic;
             PCwrite: out std_logic; 
             IorD: out std_logic;
             MemRead: out std_logic;
             MemWrite: out std_logic; 
             MemtoReg: out std_logic;
             IRWrite: out std_logic;
             RegDst: out std_logic;
             RegWrite: out std_logic;
             NewS: out std_logic_vector (3 downto 0);
             Branchsignal: out std_logic);
      end component;
      
    component ALUCUnit
        port( ALUOp: in std_logic_vector(1 downto 0);
              Ff:    in std_logic_vector(5 downto 0);
              Oper:  out std_logic_vector(2 downto 0));
      end component;
      
    component Mux2 
          port  (e0,e1: in std_logic_vector (31 downto 0);
                 C: in std_logic;
                 s: out std_logic_vector (31 downto 0));
      end component;
      
    component Mux4
          port  (e0,e1,e2,e3: in std_logic_vector (31 downto 0);
                 C: in std_logic_vector (1 downto 0);
                 s: out std_logic_vector (31 downto 0));
      end component;
      
    component registers2 generic ( DATA_WIDTH :integer := 32; ADDR_WIDTH :integer := 5 );
           port( address1 : in std_logic_vector(ADDR_WIDTH-1 downto 0); --address Input read register rs
                 address2 : in std_logic_vector(ADDR_WIDTH-1 downto 0); --address Input read register rt
                 address3 : in std_logic_vector(ADDR_WIDTH-1 downto 0); --address Input write resister rd
                 data1    : out std_logic_vector(DATA_WIDTH-1 downto 0); --data Output rs
                 data2    : out std_logic_vector(DATA_WIDTH-1 downto 0); --data output rt
                 data3    : in std_logic_vector(DATA_WIDTH-1 downto 0); --data Input 
                 RegWrite : in std_logic); 
      end component;
      
      component clockbox 
           port (clk: inout bit);
      end component;
      
      component bitsReg
            port (datareg  :in  std_logic_vector(31 downto 0);
                  clk   :in  bit;
                  qreg     :out std_logic_vector(31 downto 0));
      end component;
        
      component instructionRegister  
            port( IRWrite     : in  std_logic;
                  instrucInput : in  std_logic_vector(31 downto 0);
	     	          opCode      : out std_logic_vector(5 downto 0);
                  regRs	    : out std_logic_vector(4 downto 0);
		              regRt   	: out std_logic_vector(4 downto 0);
		              regRd   	: out std_logic_vector(4 downto 0);
		              imm         : out std_logic_vector(15 downto 0);
		              jumpAddr    : out std_logic_vector(25 downto 0);
		              funcCode    : out std_logic_vector(5 downto 0);
		              shamt       : out std_logic_vector(4 downto 0));
		   end component;  
   
       component Memory
            port( addressIn : in std_logic_vector(31 downto 0); --address Input 
                  data1 : out std_logic_vector(31 downto 0); --data Output rs
                  data3 : in std_logic_vector(31 downto 0); --data Input 
                  MemRead : in std_logic;
                  MemWrite : in std_logic);
       end component;
       
       component or2 
              port ( a :in  std_logic;
		                 b :in  std_logic;
		                 y :out std_logic);
		   end component;
		   
		   component pc
              port( writeEnable : in  std_logic;
                    addrInput   : in  std_logic_vector(31 downto 0);
                    addrOutput	: out std_logic_vector(31 downto 0));
       end component;
       
       component shiftLeft2
              port( dataIn  :in  std_logic_vector(31 downto 0);
		                dataOut :out std_logic_vector(31 downto 0));
       end component;
       
       component signExtend
              port(dataIn  :in  std_logic_vector(15 downto 0);
	                 dataOut :out std_logic_vector(31 downto 0));
       end component;
       
       component  gate2
              port ( a :in  std_logic;
  		                 b :in  std_logic;
		                 y :out std_logic);
		   end component;
		   
		   component bits5reg
		     port ( data5  :in  std_logic_vector(4 downto 0);
                clk   :in  bit;
                q5     :out std_logic_vector(4 downto 0));
       end component;
       
       component shiftleft22 
          port( dataIn :in std_logic_vector(25 downto 0);
                dataOut :out std_logic_vector(27 downto 0));
       end component;
       
       component mux2_5b 
          port  (e0,e1: in std_logic_vector (4 downto 0);
                   C: in std_logic;
                   s: out std_logic_vector (4 downto 0));
       end component;
       
       component mux2_1
           port  (e0,e1: in std_logic;
                  C: in std_logic;
                  s: out std_logic);
       end component;
       
  --places where the architecture of our components:    
      for States: New_Current use entity work.New_Current (behavioral);
      for ALUUnit: ALU use entity work.ALU (behavioral);
      for ControlUnit: CUnit use entity work.CUnit (behavioral);
      for ALUControlUnit: ALUCUnit use entity work.ALUCUnit (behave);
      for clock: clockbox use entity work.clockbox (behavioral);
      for registers_mem: registers2 use entity work.registers (rtl);
      for muxB, muxPC: Mux4 use entity work.Mux4 (behavioral);
      for muxA, muxMem, muxWrite: mux2 use entity work.mux2 (behavioral);
      for PCunit: pc use entity work.pc (behavior);
      for Memoryunit: Memory use entity work.Memory (rtl);
      for InstRegister: instructionRegister use entity work.instructionRegister (behavior);
      for SignExt: signExtend use entity work.signExtend (behavior);
      for ShifL2_1: shiftLeft2 use entity work.shiftLeft2 (behavior);
      for RegisterA, RegisterB, RegisterALUOut, RegisterMemData: bitsReg use entity work.bitsReg (behavior);
      for RegisterC: bits5reg use entity work.bits5reg (behavior);
      for Or2gate: or2 use entity work.or2 (behavior);
      for And2: gate2 use entity work.gate2 (behavior);
      for ShiftL2_2: shiftleft22  use entity work.shiftleft22  (behavior);
      for muxRD : mux2_5b use entity work.mux2_5b  (behavioral);
      for muxBranch : mux2_1 use entity work.mux2_1 (behavioral);
       
    --signals that are necessary:
    signal CS, NewS : std_logic_vector (3 downto 0);
    signal OPC,Ff : std_logic_vector (5 downto 0);
    signal ALUOp, ALUSrcB, PCSource : std_logic_vector (1 downto 0);
    signal ALUSrcA,PCWriteCond,PCwrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,RegDst,RegWrite,Zero,Branchsignal,NZero,Zerofinal,FinalPC,ZPC: std_logic;
    signal RegA,RegB,Result,data1,data2,data3,PCout,SEx,SL2,addressmem,Memdata,Writedata,MDR,ALUO,RB,RA,PCint,JAdd: std_logic_vector (31 downto 0);
    signal Oper : std_logic_vector (2 downto 0);
    signal RS,RT,RD,RegC,WriteRegister,shamt : std_logic_vector(4 downto 0);
    signal clk : bit;    
    signal IMM : std_logic_vector (15 downto 0);
    signal JA : std_logic_vector (25 downto 0);
    signal JA_1 : std_logic_vector (27 downto 0);
        
      
    
    begin
      JAdd (27 downto 0) <= JA_1(27 downto 0);
      JAdd (31 downto 28) <= PCout(31 downto 28);
      NZero <= not(Zero);
      
--connections between blocks:
      clock : clockbox PORT MAP (clk);
      States : New_Current PORT MAP (NewS,clk,CS);
      ControlUnit : CUnit PORT MAP (OPC,CS,ALUOp,ALUSrcB,ALUSrcA,PCSource,PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,RegDst,RegWrite,NewS,Branchsignal);
      ALUUnit : ALU PORT MAP (RegA,RegB,RegC,Oper,Result,Zero);
      ALUControlUnit : ALUCUnit PORT MAP (ALUOp, Ff, Oper);
      registers_mem : registers2 PORT MAP (RS,RT,WriteRegister,data1,data2,data3,RegWrite);
      Memoryunit: Memory PORT MAP (addressmem,Memdata,Writedata,MemRead,MemWrite); 
      InstRegister: instructionRegister PORT MAP (IRWrite,Memdata,OPC,RS,RT,RD,IMM,JA,Ff,shamt);
      muxRD : Mux2_5b PORT MAP ( RT, RD, RegDst, WriteRegister);
      muxWrite : Mux2 PORT MAP ( ALUO, MDR, MemtoReg, data3);
      muxMem : Mux2 PORT MAP ( PCout, ALUO, IorD, addressmem);
      muxB : Mux4 PORT MAP ( RB, "00000000000000000000000000000100", SEx, SL2, ALUSrcB, RegB);
      muxA : Mux2 PORT MAP (PCout, RA, ALUSrcA, RegA);
      muxPC : Mux4 PORT MAP (Result, ALUO, JAdd,"00000000000000000000000000000000",PCSource, PCint);  
      muxBranch : mux2_1 PORT MAP (Zero,NZero,Branchsignal,Zerofinal); 
      PCunit : pc PORT MAP (FinalPC, PCint, PCout);
      ShiftL2_2 : shiftleft22 PORT MAP (JA,JA_1);
      ShifL2_1 : shiftLeft2 PORT MAP (SEx, SL2);
      SignExt : signExtend PORT MAP (IMM,SEx);
      RegisterC : bits5reg PORT MAP (RD,clk,RegC);
      RegisterA : bitsReg PORT MAP (data1, clk, RA);
      RegisterB : bitsReg PORT MAP (data2, clk, RB);
      RegisterALUOut : bitsReg PORT MAP (Result,clk,ALUO);
      RegisterMemData: bitsReg PORT MAP (Memdata,clk,MDR);
      And2 : gate2 PORT MAP (Zerofinal, PCWriteCond, ZPC); 
      Or2gate : or2 PORT MAP (ZPC,PCWrite,FinalPC); 
        

  
end behavioral;
