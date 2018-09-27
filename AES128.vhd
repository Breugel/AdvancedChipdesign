library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity AES128 is
	Port(	key		: in std_logic_vector(127 downto 0);
		data_in		: in std_logic_vector(127 downto 0);
		clock		: in std_logic;
		reset		: in std_logic;
		ce		: in std_logic;
			
		
		data_out	: out std_logic_vector(127 downto 0);
		done		: out std_logic
	);
end AES128;


architecture Logic of AES128 is 

	component Datapad is 
		port (	State:		in std_logic_vector (1 downto 0);
			clk:		in std_logic;	
			reset:		in std_logic;
			Data_in:	in std_logic_vector(127 downto 0);
			Key_in:		in std_logic_vector(127 downto 0);
			ce:		in std_logic;
			roundcounter_in:in std_logic_vector(3 downto 0);
			
			Data_out:	out std_logic_vector(127 downto 0)
		);
	end component; 


	component Controlepad is 
	port (		clk		: in std_logic;
			reset		: in std_logic;
			ce		: in std_logic;

			done		: out std_logic;
			roundcounter_out: out std_logic_vector(3 downto 0);
			mux_state	: out std_logic_vector(1 downto 0)
		);
	end component;

signal roundcounter_signal: std_logic_vector(3 downto 0);
signal mux_state_signal: std_logic_vector(1 downto 0);





begin
	



CP: Controlepad  port map (
			clk	=>	clock, 
			reset	=>	reset,	 
			ce	=>	ce, 
			done	=>	done,
			roundcounter_out =>	roundcounter_signal,
			mux_state	=>	mux_state_signal
		);

DP: Datapad  port map (
			State	=>	mux_state_signal,
			clk	=>	clock,
			reset	=>	reset,
			Data_in	=>	data_in,
			Key_in	=>	key,
			ce	=>	ce,
			roundcounter_in	=>	roundcounter_signal,
			Data_out	=>	data_out
		);



end Logic;





