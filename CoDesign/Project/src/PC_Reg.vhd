-------------------------------------------------------------------------------
--
-- Description : This is program counter.
-- if CLR = 1 it will be reseted(0). 
-- if the LD=1 we will store the new address.
-- if INC=1 the program counter will increase one more unit.
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC_Reg is
	 port(
		 CLK : in STD_LOGIC;
		 LD : in STD_LOGIC;
		 INC : in STD_LOGIC;
		 CLR : in STD_LOGIC;
		 RIN : in STD_LOGIC_VECTOR(6 downto 0);
		 ROUT : out STD_LOGIC_VECTOR(6 downto 0)
	     );
end PC_Reg;

--}} End of automatically maintained section

architecture PC_Reg of PC_Reg is
begin
	process(CLK,CLR)
	variable tempcount : std_logic_vector( 6 downto 0) := "0000000";
	begin
		if (CLR='1') then
			tempcount:="0000000";
		elsif rising_edge(CLK) then
			if (LD = '1') then
				tempcount := RIN;
			end if;
			if (INC = '1') then
				tempcount := tempcount + 1;
			end if;
		end if;
		ROUT<=tempcount;
	end process;

end PC_Reg;