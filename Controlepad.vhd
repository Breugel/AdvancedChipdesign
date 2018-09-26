library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Controlepad is 
	port (		clk		: in std_logic;
			reset		: in std_logic;
			ce		: in std_logic;

			Data_out	: out std_logic_vector(127 downto 0);
			done		: out std_logic;
			roundcounter_out: out std_logic_vector(3 downto 0)
		);
end entity;


architecture logica of Controlepad is

	type FSM_type is
	(	initialize,
		first_round,
	 	loop_till_nine,
	 	out_loop);


	--signals
	signal roundcounter_signal: std_logic_vector(3 downto 0); --moeten tot 9 kunnen tellen
	signal curState: FSM_type;
	signal nextState: FSM_type; 
	signal chip_enable: std_logic;
	--/signals



begin	-- Begin van de "logica"

DutyCycle: process(clk)
begin
		if (rising_edge (clk)) then
			if (ce ='1') 
			then chip_enable <= '1';
			else chip_enable <= '0';		------------------------------------------------------------------------
			end if;
		end if;	 
end process;



FSM_switchstate: process(reset, clk)
begin
	if (reset = '1') then
		curState <= initialize; 
	elsif (rising_edge(clk)) then
		curState <= nextState; 
	end if;
end process;

FSM_nextstate: process (curState)
begin
	if(chip_enable = '1') then
		case curState is
			when initialize => 
				roundcounter_signal <= (others => '0');
				nextState <= first_round;
			when first_round =>
				roundcounter_signal <= roundcounter_signal + 1;
				nextState <= loop_till_nine; 
		 	when loop_till_nine =>
				if (roundcounter_signal < 10) and (roundcounter_signal >= 1) then
					roundcounter_signal <= roundcounter_signal + 1;
				else
					nextState <= out_loop;
				end if;
		 	when out_loop =>
				nextState <= initialize;
		end case;
	end if;
end process;


FSM_output: process(curState, clk)	-- Moet hier wel een klok in de sensitivity list??
begin
	case curState is
		when initialize =>
			done <= '0';
			data_out <= (others => '0');
			roundcounter_out <= (others => '0');
		when out_loop =>
			done <= '1'; 
			roundcounter_out <= roundcounter_signal;
		when others => 
			roundcounter_out <= roundcounter_signal;
			done <= '0';
	end case;
end process; 






end logica;

