library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Controlepad is 
	port (		clk		: in std_logic;
			reset		: in std_logic;
			ce		: in std_logic;

			done		: out std_logic;
			roundcounter_out: out std_logic_vector(3 downto 0);
			mux_state	: out std_logic_vector(1 downto 0)
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
	
	--/signals
    signal FSMctrCE : STD_LOGIC;


begin	-- Begin van de "logica"

--DutyCycle: process(clk)
--begin
--		if (rising_edge (clk)) then
--			if (ce ='1') 
--			then ce <= '1';
--			else ce <= '0';		------------------------------------------------------------------------
--			end if;
--		end if;	 
--end process;



FSM_switchstate: process(reset, clk)
begin
	if (reset = '1') then
		curState <= initialize; 
	elsif (rising_edge(clk)) then
		curState <= nextState; 
	end if;
end process;

FSM_nextstate: process (curState, ce, roundcounter_signal )
begin
		nextState <= curState;
		case curState is
			
				when initialize => 
					if(ce = '1') then
						--roundcounter_signal <= (others => '0');
						nextState <= first_round;
					end if;
				when first_round =>
					if(ce = '1') then
						--roundcounter_signal <= roundcounter_signal + 1;
						nextState <= loop_till_nine; 
					end if;
		 		when loop_till_nine =>
					if(ce = '1') then
					    if roundcounter_signal = 9 then
						    nextState <= out_loop;
						end if;
						--if (roundcounter_signal < 10) and (roundcounter_signal >= 1) then
						--	roundcounter_signal <= roundcounter_signal + 1;
						--else
						--	nextState <= out_loop;
						--end if;
					end if;
		 		when out_loop =>
					if( ce = '0') then
						nextState <= initialize;
					end if;
				when others =>
					--roundcounter_signal <= (others => '0');
					nextState <= intialize;
				
		end case;
end process;

PCTR: process(reset, clock)
begin
  if reset = '1' then 
    roundcounter_signal <= (others => '0');
  elsif rising_edge(clock) then
    if FSMctrCE = '1' then 
	  roundcounter_signal <= roundcounter_signal + 1;
	else
	  roundcounter_signal <= (others => '0');
	end if;
  end if;
end process;


FSM_output: process(curState)	-- Moet hier wel een klok in de sensitivity list??
begin
	case curState is
		when initialize =>
			done <= '0';
			roundcounter_out <= (others => '0');
			mux_state <= "00";
			FSMctrCE <= '0';

		when first_round =>
			done <= '0'; 
			roundcounter_out <= roundcounter_signal;
			mux_state <= "01";
			FSMctrCE <= '1';
		when loop_till_nine =>
			done <= '0';
			roundcounter_out <= roundcounter_signal;
			mux_state <= "10";
			FSMctrCE <= '1';
		when out_loop =>
			done <= '1'; 
			roundcounter_out <= roundcounter_signal;
			mux_state <= "11";
			FSMctrCE <= '0';
        when others =>
		
	end case;
end process; 


end logica;

