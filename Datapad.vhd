library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Datapad is 
	port (		Key_in_data	: in std_logic_vector (127 downto 0);
			Data_in_data	: in std_logic_vector (127 downto 0);
			clk		: in std_logic;
			reset		: in std_logic;
			ce		: in std_logic;

			Data_out	: out std_logic_vector(127 downto 0);
			done		: out std_logic
		);
end entity;


architecture logica of Datapad is

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



	component ByteSub is
   		port( 	BS_in	:in std_logic_vector( 7 downto 0 );
			BS_out	:out std_logic_vector( 7 downto 0 )
		);
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
	signal FSM: FSM_type;
	signal chip_enable: std_logic;
	

	--/signals

begin	-- Begin van de "logica"

DutyCycle: process(clk, reset)
	begin
		if reset = '0' then
			chip_enable		<= '0';
			--FSM	 	<= initialize;        ik krijg hier een error van multiple sources? hoe kan ik dat opl?
			-- moet dit commando hier niet staan in de reset?
			round_counter   <= (others => '0');
			Data_out 	<= (others => '0');
			done		<= '0';
		elsif rising_edge (clk) then
			if ce ='1' 
			then chip_enable <= '1';
			else chip_enable <= '0';
			end if;
		end if;	 
end process;




 MainProgram: process(chip_enable)
begin
	if chip_enable = '1' then	
		case FSM is
			when initialize => 
				FSM <= first_round;
				--	
				--
				--
			when first_round =>
				round_counter <= round_counter + 1;
				-- De vershillende blokken moeten hier nog in
				FSM <= loop_till_nine;
	
			when loop_till_nine =>
				if(round_counter < 10 and round_counter >= 1 ) then
					round_counter <= round_counter + 1;
				-- De vershillende blokken moeten hier nog in
				else 
					round_counter <= (others => '0');
					FSM <= out_loop;
				-- De vershillende blokken moeten hier nog in
				end if;
	
			when out_loop =>
				FSM		<= initialize;
				done		<= '1';
				chip_enable	<= '0';
		
			end case;
	end if;
end process;


end logica;

