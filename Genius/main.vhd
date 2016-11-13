LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity main is
	generic (  timeout		: STD_LOGIC_VECTOR (26 downto 0):= "010111110101111000010000000"; --50_000_000); -- 1seg
				  debounceTimer: STD_LOGIC_VECTOR (26 downto 0):= "000000000001100001101010000");
		Port ( clk					: IN  STD_LOGIC;
				 Entrada 			: IN  STD_LOGIC_VECTOR (3 downto 0):= (OTHERS => '1');
				 led					: OUT STD_LOGIC_VECTOR (7 downto 0):= (OTHERS => '0')
				 );
end main;

architecture Behavioral of main is
---------------------------------------------------------------------------------------
-- Sinais utilizados na divisão do clock.	

	signal 	timer_debounce 			: STD_LOGIC_VECTOR (26 downto 0):= (OTHERS => '0');
	signal	div_clk_1Hz					:STD_LOGIC_VECTOR (26 downto 0):= (OTHERS => '0');
---------------------------------------------------------------------------------------
-- Sinal usado para controle dos leds
	signal	signal_led					: STD_LOGIC_VECTOR (3 downto 0):= (OTHERS => '0');
	
---------------------------------------------------------------------------------------
-- ENUM para os estados do debounce
	TYPE DEBOUNCESTATES IS ( UP, DOWN, PRESSED, RELEASED);
	SIGNAL debounce : DEBOUNCESTATES:=DOWN;
begin

----------------------------------------------------------------------
---- Processo de divisor de clock 1Hz.
PROCESS_DIV_CLOCK: PROCESS(clk)
	BEGIN
	
		if rising_edge(clk)THEN 	
			-- Geração do clock de 1Hz a partir do clock de 50MHz			
			--Incrementa o divisor do clock de 1Hz
			div_clk_1Hz <= div_clk_1Hz + 1;
			IF div_clk_1Hz = timeout THEN 
				-- Alterna o sinal, gerando o clock			
				-- Zera o contador				
				div_clk_1Hz <= (OTHERS => '0');
				signal_led <= signal_led + '1';	
				led(3 downto 0)	<= signal_led;				
			end if;
			
		END IF;

END PROCESS;

----------------------------------------------------------------------
PROCESS_TIMER: PROCESS(clk, Entrada)
	BEGIN		
		 -- Borda de subida do oscilador de 50MHz.
		IF rising_edge(clk) THEN
			-- Geração do clock de 1kHz (periodo de 10ms) a partir do clock de 50MHz.
			IF timer_debounce < debounceTimer  THEN 
				timer_debounce<= timer_debounce+ 1;
			ELSE
			-- A cada 10ms verifica o estado da tecla.
				timer_debounce<= (OTHERS => '0');
				CASE (debounce) IS
					-- SINAL EM BAIXA.
					WHEN DOWN =>
							IF( Entrada /= "0000") then
							debounce <= PRESSED;
							end if;
					-- SINAL EM RAMPA DE SUBIDA.
					WHEN PRESSED =>
							IF(Entrada /= "0000") THEN
							debounce <= UP;
							led(7 downto 4)	<= ENTRADA;
							ELSE
							debounce <= DOWN;
							END IF;
					-- SINAL EM ALTA
					WHEN UP =>
							IF( Entrada = "0000") then
							debounce <= RELEASED;
							end if;
					-- SINAL EM RAMPA DE DESCIDA
					WHEN RELEASED=>
							IF( Entrada = "0000") THEN
							debounce <= DOWN;
							ELSE
								debounce <= UP;
							END IF;
				END CASE;		
			END IF;
		END IF;		
END PROCESS;

end Behavioral;

