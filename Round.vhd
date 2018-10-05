library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity round is
    Port ( round_in : in STD_LOGIC_VECTOR (127 downto 0);
           key_in: in STD_LOGIC_VECTOR (127 downto 0);
           enable: in STD_LOGIC;
           reset: in STD_LOGIC;
           clock : in STD_LOGIC;
           round_counter: in STD_LOGIC_VECTOR (3 downto 0);
           round_tussen: out STD_LOGIC_VECTOR (127 downto 0);
           data_out_ARK: out STD_LOGIC_VECTOR (127 downto 0); 
           round_out : out STD_LOGIC_VECTOR (127 downto 0));
end round;

architecture Behavioral of round is

signal data1, data2,data3,key_ex : std_logic_vector(127 downto 0);

component Exor is 
    Port ( exor_in : in STD_LOGIC_VECTOR (127 downto 0);
           key_in :  in STD_LOGIC_VECTOR (127 downto 0);

           exor_out : out STD_LOGIC_VECTOR (127 downto 0));
end component;




component ShiftRow is 
  port (  shiftrow_in : in std_logic_vector(127 downto 0);
          shiftrow_out : out std_logic_vector(127 downto 0));
end component;


component MixColumn is 
	port (	MC_in : in std_logic_vector (127 downto 0);
			MC_out : out std_logic_vector(127 downto 0)
			);
end component;

component Keyscheduler is 
	port( roundcounter:	   in STD_LOGIC_VECTOR(3 downto 0);
			clock:         in std_logic; 
			reset:         in std_logic;
			ce:            in std_logic;
			key:    	   in std_logic_vector(127 downto 0);
			
			key_out:	   out std_logic_vector(127 downto 0)
	);
end component;

component Subbytes is
    Port ( sub_in : in STD_LOGIC_VECTOR (127 downto 0);
           sub_out : out STD_LOGIC_VECTOR (127 downto 0));
end component;


begin

KS: Keyscheduler port map ( roundcounter => round_counter, clock => clock, reset => reset, ce => enable, key => key_in, key_out => key_ex);
EX1:Exor port map( exor_in => round_in, key_in => key_ex, exor_out => data1);
Sb: Subbytes port map (sub_in => data1, sub_out => data2);
SR: ShiftRow port map (shiftrow_in => data2, shiftrow_out => data3);
MC: mixColumn port map(MC_in => data3, MC_out => round_out);

 round_tussen <= data3;
 data_out_ARK <= data1;


end Behavioral;
