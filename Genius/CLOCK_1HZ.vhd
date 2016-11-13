LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY CLOCK_1HZ IS

	PORT ( input_clk		: IN  STD_LOGIC;
			 clk_1hz : out  STD_LOGIC
			 );

END CLOCK_1HZ;

ARCHITECTURE BEHAVIORAL OF CLOCK_1HZ IS

	SIGNAL	div_clk_1Hz	:STD_LOGIC_VECTOR (26 DOWNTO 0):= (OTHERS => '0');
	BEGIN
	-- Processo de divisor de clock 1Hz.
		PROCESS_DIV_CLOCK: PROCESS(clk)
			BEGIN
				if rising_edge(clk)THEN 	
					-- Geração do clock de 1Hz a partir do clock de 50MHz			
					--Incrementa o divisor do clock de 1Hz
					div_clk_1Hz <= div_clk_1Hz + 1;
					clk_1hz <= '0';
					IF div_clk_1Hz = timeout THEN 
						-- Alterna o sinal, gerando o clock			
						-- Zera o contador				
						div_clk_1Hz <= (OTHERS => '0');
						clk_1hz <= '1';			
					END IF;					
				END IF;
		END PROCESS;
END Behavioral

