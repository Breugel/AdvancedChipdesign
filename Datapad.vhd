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

entity data_path is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (127 downto 0);
           ce: in STD_LOGIC;
           --multiplex_state: in STD_LOGIC_VECTOR(2 downto 0);
           MpReg: in STD_LOGIC;
           MpOut : in STD_LOGIC;
           MpIn  : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (127 downto 0);
           round_counter: in STD_LOGIC_VECTOR(3 downto 0);
           key_in : in STD_LOGIC_VECTOR (127 downto 0));
           
end data_path;

architecture Behavioral of data_path is


signal data_round_in :  STD_LOGIC_VECTOR (127 downto 0);
signal data_after_round,data_round_tussen,data_after_reg,data_out_ARK,data_out_signal :STD_LOGIC_VECTOR (127 downto 0);

component round is
    Port ( round_in :       in STD_LOGIC_VECTOR (127 downto 0);
           key_in:          in STD_LOGIC_VECTOR (127 downto 0);
           enable:          in STD_LOGIC;
           reset:           in STD_LOGIC;
           clock :         in STD_LOGIC;
           round_counter:  in STD_LOGIC_VECTOR (3 downto 0);
           round_tussen:      out STD_LOGIC_VECTOR (127 downto 0); 
           data_out_ARK: out STD_LOGIC_VECTOR (127 downto 0); 
           round_out : out STD_LOGIC_VECTOR (127 downto 0));
end component;



begin
  


      
      
-- data_doorvoer: process (multiplex_state,data_after_round,data_in,data_round_tussen)
--      begin
--           if  multiplex_state = "01" then 
--               data_round_in <= data_in;
--              data_out <= (others => '0');
--           elsif  multiplex_state = "10" then
--               data_round_in <= data_after_round;
--               data_out <= (others => '0');
--                --data_round_in <= data_in;
--           elsif  multiplex_state = "11" then  
 --              data_round_in <= data_in; -- deze moet aangepast worden vanuit het register.
  --             data_out <= data_round_tussen;
   --        else 
    --            data_round_in <= data_in;
     --           data_out <= (others => '0');
      --     end if;
     -- end process;      
      

      
      
      
  
      
      
      
mux_data_in: process (MpIn,data_after_reg,data_in)
begin
           if  MpIn = '1' then 
               data_round_in <= data_after_reg;
               
           --elsif  multiplex_state = "10" or multiplex_state = "11" then
              -- data_round_in <= data_after_reg;
           else 
                data_round_in <= data_in;
           end if;
           
end process;

mux_data_out: process (MpOut,data_round_tussen)
begin
           if  MpOut = '1' then 
               data_out <= data_out_ARK;

           else 
                data_out <= (others => '0');
           end if;
           
end process;

--reg1: process (reset, clock)
--begin
--  
--           if (reset = '1') then
--             data_out <= (others => '0');
--           elsif (rising_edge(clock)) then 
--                if(MpOut = '0' or rising_edge(MpOut)) then
--                  data_out <= data_out_signal;                  
--                end if; 
--          end if;     
--end process;




reg2: process (reset, clock)
begin
  
           if (reset = '1') then
             data_after_reg <= (others => '0');
           elsif (rising_edge(clock)) then 
                if(round_counter < 11) then
                    if(MpReg = '0') then
                         data_after_reg <= data_after_round;
                    else
                         data_after_reg <= data_round_tussen;
                  end if; 
              end if; 
          end if;     
end process;



        
      
      
  
  --Rd1: round port map (data_round_in, key_in, ce, reset, clock, data_after_round);
    --RL: round_last port map (data_round_in, key_in, ce, reset, clock, data_out);

 Rd1: round port map (data_round_in, key_in, ce, reset, clock,round_counter,data_round_tussen, data_out_ARK,data_after_round);
 

 

           
   

end Behavioral;
