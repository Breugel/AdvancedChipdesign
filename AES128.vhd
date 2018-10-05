library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AES128 is
    Port ( data_in : in STD_LOGIC_VECTOR (127 downto 0);
           data_out : out STD_LOGIC_VECTOR (127 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           key : in STD_LOGIC_VECTOR (127 downto 0);
           done : out STD_LOGIC);
end AES128;




  

architecture Behavioral of AES128 is

signal round_counter: STD_LOGIC_VECTOR(3 downto 0);
signal  multiplex_state: STD_LOGIC_VECTOR(1 downto 0);
signal MpReg_aes,MpOut_aes,MpIn_aes: STD_LOGIC;



component data_path is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (127 downto 0);
           ce: in STD_LOGIC;
           --multiplex_state: in STD_LOGIC_VECTOR(1 downto 0);
           MpReg: in STD_LOGIC;
           MpOut : in STD_LOGIC;
           MpIn  : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (127 downto 0);
           round_counter: in STD_LOGIC_VECTOR(3 downto 0);
           key_in : in STD_LOGIC_VECTOR (127 downto 0));
           
end component;

component control_p is
    Port ( 
        reset : in STD_LOGIC;
        clock : in STD_LOGIC;
        --multiplex_state: out STD_LOGIC_VECTOR(1 downto 0);
        done: out STD_LOGIC;
        ce: in STD_LOGIC;
        roundcounter_out: out STD_LOGIC_VECTOR(3 downto 0);
        MpReg : out STD_LOGIC;
        MpOut : out STD_LOGIC;
        MpIn  : out STD_LOGIC
       );
end component;


begin

DP: data_path Port map ( clock => clock,
                          reset => reset, 
                          data_in => data_in, 
                          ce => ce, 
                          --multiplex_state => multiplex_state,
                           MpReg => MpReg_aes,
                           MpOut => MpOut_aes,
                           MpIn => MpIn_aes,
                          data_out => data_out,
                          round_counter => round_counter,
                           key_in => key
                          );
                          
CP: control_p Port map( reset => reset,
                        clock => clock,
                        --multiplex_state => multiplex_state,
                        done => done ,
                        ce => ce ,
                        roundcounter_out => round_counter,
                        MpReg => MpReg_aes,
                        MpOut => MpOut_aes,
                        MpIn => MpIn_aes
                        );


end Behavioral;
