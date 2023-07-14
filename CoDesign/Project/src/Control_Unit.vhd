-------------------------------------------------------------------------------
--
-- Description :  This is controlunit based on ASM chart. 
-- If reset=0 all the outputs will be zero.
-- And for prevent the making FF we give zero to all the outputs before checking the states.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity Control_Unit is
	 PORT( ZR0: in std_logic;
			ZR1: in std_logic;
			ZR2: in std_logic;
			ZR3: in std_logic;
			CLK: in std_logic;
			ROUTIR : in STD_LOGIC_VECTOR(6 downto 0);
			BUS_Sel: out std_logic;
			CMD : out STD_LOGIC_VECTOR(1 downto 0);
			LD0: out std_logic;
			LD1: out std_logic;
			RST: out std_logic;
			LD2: out std_logic;
			LD3: out std_logic;
			LDPC: out std_logic;
			LDIR: out std_logic;
			Sel0 : out STD_LOGIC_VECTOR(1 downto 0);
		 	Sel1 : out STD_LOGIC_VECTOR(1 downto 0);
			INC: out std_logic) ;
end Control_Unit;

--}} End of automatically maintained section

architecture Control_Unit of Control_Unit is
TYPE state is (S0, S1, D, S2, S3, S4, S5, S6, S7, S8);
signal state_reg, state_next: state;
Signal ZR : std_logic_vector(3 downto 0);
Signal i: integer;
begin
	i <= to_integer(unsigned(ROUTIR(3 downto 2)));
	ZR(0) <= ZR0;
	ZR(1) <= ZR1;
	ZR(2) <= ZR2;
	ZR(3) <= ZR3;
	
	process(CLK)
	begin  
			
		if rising_edge(CLK) then
			state_reg <= state_next;
		end if;
	end process;
	
	process(state_reg,ZR0,ZR1,ZR2,ZR3,ROUTIR)
	begin
	RST<='0';
	INC<='0';
	CMD<="00";
	BUS_Sel<='0';
	LDIR<='0';
	LDPC<='0';
	LD3<='0';
	LD2<='0';
	LD1<='0';
	LD0<='0';	
	
	case state_reg is
		when S0 =>
		state_next <= S1;
		RST <= '1';	
		
		when S1 =>
		state_next <= D;
		LDIR <= '1';
		INC <= '1';
		BUS_Sel <='0'; 
		
		when D=>
		if(ROUTIR = "0000000") then
			state_next<=S2;
		elsif(ROUTIR(6 downto 4) = "000")then
			state_next<=S3;
		elsif(ROUTIR(6 downto 4) = "001")then
			state_next<=S4;
		elsif(ROUTIR(6 downto 4) = "010")then
			state_next<=S5;
		elsif (ROUTIR(6 downto 4) = "011") then 
			if (ZR(i) ='0') then
				state_next<=S7;
			else
				state_next<=S6;
			end if;
		elsif (ROUTIR(6 downto 4) = "100") then
			state_next<=S8;
			end if;

		when S2=>
		state_next <= S2;
		
		when S3 =>
			if(ROUTIR(3 downto 2) = "00") then
					LD0 <= '1';
			elsif(ROUTIR(3 downto 2) = "01") then
				LD1 <= '1';
			elsif(ROUTIR(3 downto 2) = "10") then
				LD2 <= '1';
			else
				LD3 <= '1';
			end if;
			INC <= '1';
			BUS_Sel <= '0';
			state_next <= S1;
			
		when S4 =>
			if(ROUTIR(3 downto 2) = "00") then
				LD0 <= '1';
			elsif(ROUTIR(3 downto 2) = "01") then
				LD1 <= '1';
			elsif(ROUTIR(3 downto 2) = "10")then
				LD2 <= '1';
			else
				LD3 <= '1';
			end if;
			
			
			Sel0 <= ROUTIR(3 downto 2);
			Sel1 <= ROUTIR(1 downto 0);
			
			CMD <= "00";
			BUS_Sel <= '1';
			state_next<=S1;
			
			
		when S5 =>
			if(ROUTIR(3 downto 2) = "00")  then
				LD0 <= '1';
			elsif(ROUTIR(3 downto 2) = "01") then
				LD1 <= '1';
			elsif(ROUTIR(3 downto 2) = "10") then
				LD2 <= '1';
			else
				LD3 <= '1';
			end if;
			
			Sel0 <= ROUTIR(3 downto 2);
			Sel1 <= ROUTIR(1 downto 0);
			
			BUS_Sel <= '1';
			CMD <= "01";
			state_next<=S1;
			
		when S6 =>
			LDPC<='1';
			BUS_Sel<='0';
			state_next<=S1;
		
		when S7 =>
			INC<='1';
			state_next<=S1;
		 ---------
		when S8 =>
			if(ROUTIR(3 downto 2) = "00") then
				LD0 <= '1';
			elsif(ROUTIR(3 downto 2) = "01") then
				LD1 <= '1';
			elsif(ROUTIR(3 downto 2) = "10")then
				LD2 <= '1';
			else
				LD3 <= '1';
			end if;
			
			CMD<="10";
			Sel0 <= ROUTIR(3 downto 2);
			Sel1 <= ROUTIR(1 downto 0);
			
			BUS_Sel <= '1';
			state_next<=S1;
		---------------
		end case;
	end process;
	 -- enter your statements here --

end Control_Unit;
