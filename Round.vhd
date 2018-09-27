library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Round is
	Port(	Key_in		: in std_logic_vector(127 downto 0);
		Data_in		: in std_logic_vector(127 downto 0);
		clk		: in std_logic;
		reset		: in std_logic;
		roundcounter	: in STD_LOGIC_VECTOR(3 downto 0);
		ce		: in std_logic;
			
		
		Round_out	: out std_logic_vector(127 downto 0);
		RoundTussen	: out std_logic_vector(127 downto 0)
	);
end Round;


architecture Logic of Round is 
	component Keyscheduler is 
		port(	roundcounter:	in STD_LOGIC_VECTOR(3 downto 0);
			clock:		in std_logic; 
			reset:		in std_logic;
			ce:		in std_logic;
			key:		in std_logic_vector(127 downto 0);
			key_out:	out std_logic_vector(127 downto 0)
	);
	end component;


	component AddRoundKey is 
		port (  Key_in		: in std_logic_vector (127 downto 0);	--Deze komt van uitgang KE
			Data_in		: in std_logic_vector(127 downto 0);	-- Kan van buitenaf komen (voor eerste keer) of van uitgang MC
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


	signal keyout_signal, ARK_out_signal, SB_out_signal, SR_out_signal : std_logic_vector(127 downto 0);

begin 
	
	part1	: Keyscheduler	port map (roundcounter, clk, reset, ce, Key_in, keyout_signal);
	part2	: AddRoundKey	port map (keyout_signal, Data_in, ARK_out_signal);
	part3	: Subbytes	port map (ARK_out_signal, SB_out_signal);
	part4	: ShiftRow	port map (SB_out_signal, SR_out_signal);
	part5	: MixColumn	port map (SR_out_signal, Round_out);
	
	RoundTussen <= SR_out_signal;

end Logic;
