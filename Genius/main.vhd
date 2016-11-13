LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
	
		Port ( clk					: IN  STD_LOGIC;
				 Entrada 			: IN  STD_LOGIC_VECTOR (3 downto 0):= (OTHERS => '1');
				 led					: OUT STD_LOGIC_VECTOR (3 downto 0):= (OTHERS => '0')
				 );
end main;

architecture Behavioral of main is
---------------------------------------------------------------------------------------
-- Sinais utilizados na divisão do clock.	

signal freq10M : STD_LOGIC;
---------------------------------------------------------------------------------------
-- Sinal usado para controle dos leds
	signal	signal_led					: STD_LOGIC_VECTOR (3 downto 0):= (OTHERS => '0');
	
---------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
-- COMPONENTES
component freqDiv is
	port ( input   : in   STD_LOGIC;
			 output4 : out STD_LOGIC);
end component;

	COMPONENT DEBOUNCE
	PORT(
		input : IN std_logic;
		ENTRADA : IN std_logic_vector(3 downto 0);          
		SAIDA : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
begin

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
process(freq10M)
begin
			if rising_edge(freq10M) then
				 led <= signal_led;				
			end if;
end process;

freqDiv1: freqDiv port map ( 
										input => clk, 	
										output4 => freq10M
										);

Inst_DEBOUNCE: DEBOUNCE PORT MAP(
		input => freq10M,
		ENTRADA => Entrada,
		SAIDA => signal_led
	);

end Behavioral;