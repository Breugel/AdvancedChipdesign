
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Datapad is 
	port (	State:		in std_logic_vector (1 downto 0);
		clk:		in std_logic;	
		reset:		in std_logic;
		Data_in:	in std_logic_vector(127 downto 0);
		Key_in:		in std_logic_vector(127 downto 0);
		ce:		in std_logic;
		roundcounter_in:in std_logic_vector(3 downto 0);
		
		Data_out:	out std_logic_vector(127 downto 0)
		);
end Datapad;


Architecture Logica of Datapad is 
	component Round is port(
		Key_in		: in std_logic_vector(127 downto 0);
		Data_in		: in std_logic_vector(127 downto 0);
		clk		: in std_logic;
		reset		: in std_logic;
		roundcounter	: in STD_LOGIC_VECTOR(3 downto 0);
		ce		: in std_logic;
			
		
		Round_out	: out std_logic_vector(127 downto 0);	-- MC_out
		RoundTussen	: out std_logic_vector(127 downto 0)	-- SR_out
		);
	end component;

signal data_round_in, data_output_mc,data_output_SR : std_logic_vector (127 downto 0);



begin 

	program: process (State, data_in)
		begin
			if State = "01" then				-- eerste rondje
				data_round_in <= data_in;
			elsif State = "10" then			-- loop till nine
				data_round_in <= data_output_mc;
			elsif State = "11" then			-- out loop
				data_round_in <= data_output_mc;
				Data_out <= data_output_SR;
			elsif State = "00" then
				Data_out <= (others => '0');
			
			end if;
		end process;





rondje: Round port map ( 
		Key_in		=>	Key_in,
		Data_in		=>	data_round_in,
		clk		=>	clk,
		reset		=>	reset,
		roundcounter	=>	roundcounter_in,
		ce		=>	ce,
			
		
		Round_out	=>	data_output_mc,
		RoundTussen	=>	data_output_SR
);

end Logica;


