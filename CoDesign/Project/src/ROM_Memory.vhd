
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity ROM_Memory is port(
		 Address : in STD_LOGIC_VECTOR(6 downto 0);
		 Data : out STD_LOGIC_VECTOR(6 downto 0)
	     );
end ROM_Memory;

--}} End of automatically maintained section

architecture ROM_Memory of ROM_Memory is
type mem is array ( 63 downto 0) of std_logic_vector(6 downto 0);
signal memory:mem;
begin
	
----Adding 7 and 4
--	--load R0,7
--	memory(0) <= "0000011";
--	memory(1) <= "0000111";	  
--	
--	--load R1,4
--	memory(2) <= "0000111"; 
--	memory(3) <= "0000100";	
--	
--	--add R0,R1
--	memory(4) <= "0010001";
--	memory(5) <= "0000000";
--
--
--
--
--	--Multiply 8 to 6 
--	--load R0,0
--	memory(0) <= "0000011";
--	memory(1) <= "0000000";
--
--	--load R1,8
--	memory(2) <= "0000111"; 
--	memory(3) <= "0001000";
--
--	--load R2,6
--	memory(4) <= "0001011";
--	memory(5) <= "0000110";
--
--	--load R3,1
--	memory(6) <= "0001111";
--	memory(7) <= "0000001";
--
--	--add R0,R2
--	memory(8) <= "0010010";
--
--	--sub R1,R3
--	memory(9) <= "0100111";
--	
--	--JNZ R1, linr add (memory(8))
--	memory(10) <= "0110111";
--	memory(11) <= "0001000";
--	
--	--HLT
--	memory(12) <= "0000000"; 
--
--	--Multiply 8 to 6
--	--load R0,8
--	memory(0) <= "0000011";
--	memory(1) <= "0001000";
--
--	--load R1,6
--	memory(2) <= "0000111"; 
--	memory(3) <= "0000110";
--
--	--Mul R0 , R1 
--	memory(4) <= "1000001";

	 Data <=memory(to_integer(unsigned(Address)));

end ROM_Memory;
