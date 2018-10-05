
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Exor is 
    Port ( exor_in : in STD_LOGIC_VECTOR (127 downto 0);
           key_in : in STD_LOGIC_VECTOR (127 downto 0);
           exor_out : out STD_LOGIC_VECTOR (127 downto 0));
end Exor;

architecture Behavioral of Exor is

begin
    process(key_in, exor_in)
        begin
            exor_out <= exor_in xor key_in;
        end process;    
         

end Behavioral;
