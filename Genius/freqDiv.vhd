library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity freqDiv is

    Port ( input   : in  STD_LOGIC;
			  output4 : out STD_LOGIC);

end freqDiv;

architecture Behavioral of freqDiv is

	signal freq50MHz : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');	
	
begin

	process(input)
	begin
		if rising_edge(input) then --rising_edge is used to detect signal transition from logic zero to logic one
			freq50MHz <= freq50MHz + 1;
			if freq50MHz(3) = '1' then
					output4 <= '1';
					freq50MHz <= (others => '0');
			else
					output4 <= '0';
			end if;
		end if;

	end process;

end Behavioral;
