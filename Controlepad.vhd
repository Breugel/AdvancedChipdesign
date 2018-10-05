library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_p is
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
end control_p;

architecture Behavioral of control_p is

  type tStates is (idle,round_till_nine, last_round, after_encrypt,first_round);
  signal curState, nxtState : tStates;
  signal roundcounter: STD_LOGIC_VECTOR(3 downto 0);  
  signal multiplex_state: STD_LOGIC_VECTOR(2 downto 0);
  signal FSMctrCE : STD_LOGIC;

begin


FSM_switchstate : process (reset, clock,ce)
begin
  
    if reset = '1' then 
        curState <= idle;
    elsif (rising_edge(clock)) then 
        curState <= nxtState; 
    end if;
    
end process;




FSM_nextstate : process (curState,ce,roundcounter)
  begin
      nxtState <= curState;
      case curState is
        
                when idle =>
                      if (ce = '1') then
                            nxtState <= first_round;
                      end if;
            
                when first_round =>
                      if  ce = '1' and roundcounter = 1 then   -- kan een if else van gemaakt worden ipv een if elsif
                            nxtState <= round_till_nine;

                      end if;
                     
                when round_till_nine =>
                      if(ce = '1')then
                          if roundcounter = 9 then
                            nxtState <= last_round;
                          end if;
                      end if;
                      
                      
                when last_round =>
                      if(ce = '1')then
                          if roundcounter = 10 then
                            nxtState <= after_encrypt;
                          end if; 
                      end if;
                      
                when after_encrypt =>
                  
                      if  ce = '0' then 
                            nxtState <=  idle;
                      end if;
         
                when others =>
                      nxtState <= idle;
    end case;
    
end process;
  
  
PCTR: process(reset, clock,ce,FSMctrCE)
begin
  
    if reset = '1' then 
          roundcounter <= (others => '0');
    elsif rising_edge(clock) then
          if FSMctrCE = '1' then 
                  if ce = '1' and curState /= after_encrypt and roundcounter < 11 then
                         roundcounter <= roundcounter + 1;
                  end if;
          else
                  roundcounter <= (others => '0');
          end if;
    end if;
  end process;
  
  
  FSM_output : process (curState,roundcounter)
    begin
      case curState is
      
         when idle =>
                done <= '0';     
                multiplex_state <= "000";
                roundcounter_out <= (others => '0');    
                FSMctrCE <= '0';
                MpReg <= '0';  
                MpOut <= '0';
                MpIn <= '0';  
                                 
        when first_round =>
                done <= '0';     
                multiplex_state <= "001";
                roundcounter_out <= roundcounter;    
                FSMctrCE <= '1';
                MpReg <= '0';
                MpOut <= '0';
                MpIn <= '0';  
                 
        when round_till_nine =>
                done <= '0';     
                multiplex_state <= "010";
                roundcounter_out <= roundcounter;    
                FSMctrCE <= '1';
                MpReg <= '0';
                MpOut <= '0';
                MpIn <= '1';
                
        when last_round =>
                done <= '0';     
                multiplex_state <= "011";
                roundcounter_out <= roundcounter;    
                FSMctrCE <= '1';
                MpReg <= '1';
                MpOut <= '0';
                MpIn <= '1';         
                    
                 
        when after_encrypt => 
                done <= '1';     
                multiplex_state <= "100";
                roundcounter_out <= roundcounter;    
                FSMctrCE <= '0';
                MpReg <= '1';   
                MpOut <= '1';
                MpIn <= '1';    
                          
        when others =>
                done <= '0';     
                multiplex_state <= "000";
                roundcounter_out <= (others => '0');    
                FSMctrCE <= '0';
                MpReg <= '0';
                MpOut <= '0';
                MpIn <= '0'; 
  
        
      end case;
    end process;
  
      roundcounter_out <= roundcounter;
  end Behavioral;
