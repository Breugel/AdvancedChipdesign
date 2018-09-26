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
			
		
		Data_out	: out std_logic_vector(127 downto 0)
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


	signal keyout, ARK_out, SB_out, SR_out : std_logic_vector(127 downto 0);

begin 
	
	part1	: Keyscheduler	port map (roundcounter, clk, reset, ce, Key_in, keyout);
	part2	: AddRoundKey	port map (keyout, Data_in, ARK_out);
	part3	: Subbytes	port map (ARK_out, SB_out);
	part4	: ShiftRow	port map (SB_out, SR_out);
	part5	: MixColumn	port map (SR_out, Data_out);

end Logic;
