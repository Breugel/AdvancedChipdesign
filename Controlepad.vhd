library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Controlepad is 
	port (		Key_in_data	: in std_logic_vector (127 downto 0);
			Data_in_data	: in std_logic_vector (127 downto 0);
			clk		: in std_logic;
			reset		: in std_logic;
			ce		: in std_logic;

			Data_out	: out std_logic_vector(127 downto 0);
			done		: out std_logic
		);
end entity;


architecture logica of Controlepad is

	type FSM_type is
	(	initialize,
		first_round,
	 	loop_till_nine,
	 	out_loop);

----------------------------------------------------------------------------------
	component Keyscheduler is 
		port(	roundcounter	: in STD_LOGIC_VECTOR(3 downto 0);
			clock		: in std_logic; 
			reset		: in std_logic;
			ce		: in std_logic;
			key		: in std_logic_vector(127 downto 0);
			key_out		: out std_logic_vector(127 downto 0)
		);
	end component;


	component AddRoundKey is 
		port (  Key_in		: in std_logic_vector (127 downto 0);
			Data_in		: in std_logic_vector(127 downto 0);
			Round_Key_out	: out std_logic_vector(127 downto 0)
		);
	end component;



	component Subbytes is 
 		port (  p_in : in std_logic_vector(127 downto 0);
          		s_out : out std_logic_vector(127 downto 0));
	end component;

	
	component ShiftRow is 
  		port (  shiftrow_in	: in std_logic_vector(127 downto 0);
          		shiftrow_out	: out std_logic_vector(127 downto 0));
	end component;

	
	component MixColumn is 
		port (	MC_in	: in std_logic_vector (127 downto 0);
			MC_out	: out std_logic_vector(127 downto 0)
		);
	end component;
-----------------------------------------------------------------------------------------



	--signals
	signal round_counter: std_logic_vector(3 downto 0); --moeten tot 9 kunnen tellen
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
				round_counter <= (others => '0');
				nextState <= first_round;
			when first_round =>
				round_counter <= round_counter + 1;
				nextState <= loop_till_nine; 
		 	when loop_till_nine =>
				if (round_counter < 10) and (round_counter >= 1) then
					round_counter <= round_counter + 1;
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
			round_counter <= (others => '0');
		when first_round =>
			done <= '0';
		when loop_till_nine =>
			done <= '0';
		when out_loop =>
			done <= '1'; 
	end case;
end process; 






end logica;

