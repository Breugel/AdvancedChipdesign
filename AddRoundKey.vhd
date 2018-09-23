library ieee;
use ieee.std_logic_1164.all;

entity AddRoundKey is 
	port (		Key_in : in std_logic_vector (127 downto 0);
					Data_in : in std_logic_vector(127 downto 0);
					Round_Key_out : out std_logic_vector(127 downto 0)
		);
end AddRoundKey;


architecture Behavioral of AddRoundKey is

begin
	process (Key_in, Data_in)
	begin
		Round_Key_out <= Key_in xor Data_in;
	end process;
end Behavioral;