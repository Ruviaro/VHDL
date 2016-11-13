library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DEBOUNCE is
	 Port ( 
				input   : in  STD_LOGIC;
				ENTRADA : in   STD_LOGIC_VECTOR (3 downto 0);			 
				SAIDA   : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
			  
end DEBOUNCE;

architecture Behavioral of DEBOUNCE is
	
-- ENUM para os estados do debounce
	TYPE DEBOUNCESTATES IS ( UP, DOWN, PRESSED, RELEASED);
	SIGNAL debounce : DEBOUNCESTATES:=DOWN;

begin
---- Processo de DEBOUNCE.
PROCESS(input)
BEGIN	
		if rising_edge(input) then 
			CASE (debounce) IS
				-- SINAL EM BAIXA.
				WHEN DOWN =>
				SAIDA <= "0000";
						IF( Entrada /= "0000") then
						debounce <= PRESSED;
						end if;
				-- SINAL EM RAMPA DE SUBIDA.
				WHEN PRESSED =>
						IF(Entrada /= "0000") THEN
						debounce <= UP;
						SAIDA	<= ENTRADA;
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
		end if;
END PROCESS;

end Behavioral;

