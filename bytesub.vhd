library ieee;
use ieee.std_logic_1164.all;

entity ByteSub is
   port( BS_in :in std_logic_vector( 7 downto 0 );
         BS_out :out std_logic_vector( 7 downto 0 )
);
end ByteSub;

architecture internals of ByteSub is

begin
  process(BS_in)
  begin
    case BS_in is
      when "01000010" => BS_out <= "00101100";
      when "10101000" => BS_out <= "11000010";
      when "10110110" => BS_out <= "01001110";
      when "00011010" => BS_out <= "10100010";
      when "00111000" => BS_out <= "00000111";
      when "11011000" => BS_out <= "01100001";
      when "00000101" => BS_out <= "01101011";
      when "00101111" => BS_out <= "00010101";
      when "00110101" => BS_out <= "10010110";
      when "00111111" => BS_out <= "01110101";
      when "10000010" => BS_out <= "00010011";
      when "00000110" => BS_out <= "01101111";
      when "00100011" => BS_out <= "00100110";
      when "10010010" => BS_out <= "01001111";
      when "11000000" => BS_out <= "10111010";
      when "11010000" => BS_out <= "01110000";
      when "10111010" => BS_out <= "11110100";
      when "10010111" => BS_out <= "10001000";
      when "10101011" => BS_out <= "01100010";
      when "11100110" => BS_out <= "10001110";
      when "11101100" => BS_out <= "11001110";
      when "00011101" => BS_out <= "10100100";
      when "00000000" => BS_out <= "01100011";
      when "10100010" => BS_out <= "00111010";
      when "11000001" => BS_out <= "01111000";
      when "00011001" => BS_out <= "11010100";
      when "01101110" => BS_out <= "10011111";
      when "11101011" => BS_out <= "11101001";
      when "11101111" => BS_out <= "11011111";
      when "00100111" => BS_out <= "11001100";
      when "11110100" => BS_out <= "10111111";
      when "00000001" => BS_out <= "01111100";
      when "00011011" => BS_out <= "10101111";
      when "01110111" => BS_out <= "11110101";
      when "11010101" => BS_out <= "00000011";
      when "00010111" => BS_out <= "11110000";
      when "00111100" => BS_out <= "11101011";
      when "10111011" => BS_out <= "11101010";
      when "01000000" => BS_out <= "00001001";
      when "11111011" => BS_out <= "00001111";
      when "01111001" => BS_out <= "10110110";
      when "10110000" => BS_out <= "11100111";
      when "10100100" => BS_out <= "01001001";
      when "11000010" => BS_out <= "00100101";
      when "11110111" => BS_out <= "01101000";
      when "00110100" => BS_out <= "00011000";
      when "01011100" => BS_out <= "01001010";
      when "00001101" => BS_out <= "11010111";
      when "00111110" => BS_out <= "10110010";
      when "01010010" => BS_out <= "00000000";
      when "01001111" => BS_out <= "10000100";
      when "11000101" => BS_out <= "10100110";
      when "11110110" => BS_out <= "01000010";
      when "01110110" => BS_out <= "00111000";
      when "00100010" => BS_out <= "10010011";
      when "00101011" => BS_out <= "11110001";
      when "11001000" => BS_out <= "11101000";
      when "01010110" => BS_out <= "10110001";
      when "10101111" => BS_out <= "01111001";
      when "11011010" => BS_out <= "01010111";
      when "11111010" => BS_out <= "00101101";
      when "00101110" => BS_out <= "00110001";
      when "11011001" => BS_out <= "00110101";
      when "11100000" => BS_out <= "11100001";
      when "01101111" => BS_out <= "10101000";
      when "11100100" => BS_out <= "01101001";
      when "01000101" => BS_out <= "01101110";
      when "00001000" => BS_out <= "00110000";
      when "00000010" => BS_out <= "01110111";
      when "00011000" => BS_out <= "10101101";
      when "00010100" => BS_out <= "11111010";
      when "01000001" => BS_out <= "10000011";
      when "10101110" => BS_out <= "11100100";
      when "10100110" => BS_out <= "00100100";
      when "01110000" => BS_out <= "01010001";
      when "01010100" => BS_out <= "00100000";
      when "11100001" => BS_out <= "11111000";
      when "10111000" => BS_out <= "01101100";
      when "00100110" => BS_out <= "11110111";
      when "10110011" => BS_out <= "01101101";
      when "11000100" => BS_out <= "00011100";
      when "11100111" => BS_out <= "10010100";
      when "11101010" => BS_out <= "10000111";
      when "00001100" => BS_out <= "11111110";
      when "00110110" => BS_out <= "00000101";
      when "01010000" => BS_out <= "01010011";
      when "11101000" => BS_out <= "10011011";
      when "10001110" => BS_out <= "00011001";
      when "11001001" => BS_out <= "11011101";
      when "11001011" => BS_out <= "00011111";
      when "10111100" => BS_out <= "01100101";
      when "00100100" => BS_out <= "00110110";
      when "01011110" => BS_out <= "01011000";
      when "01001000" => BS_out <= "01010010";
      when "10000011" => BS_out <= "11101100";
      when "11100101" => BS_out <= "11011001";
      when "11011101" => BS_out <= "11000001";
      when "00010000" => BS_out <= "11001010";
      when "01001101" => BS_out <= "11100011";
      when "01111010" => BS_out <= "11011010";
      when "11010100" => BS_out <= "01001000";
      when "00101100" => BS_out <= "01110001";
      when "01011011" => BS_out <= "00111001";
      when "01011101" => BS_out <= "01001100";
      when "10011100" => BS_out <= "11011110";
      when "01001110" => BS_out <= "00101111";
      when "11001110" => BS_out <= "10001011";
      when "00011111" => BS_out <= "11000000";
      when "00101010" => BS_out <= "11100101";
      when "11110000" => BS_out <= "10001100";
      when "00110111" => BS_out <= "10011010";
      when "11101101" => BS_out <= "01010101";
      when "11100011" => BS_out <= "00010001";
      when "10011011" => BS_out <= "00010100";
      when "01010001" => BS_out <= "11010001";
      when "10100101" => BS_out <= "00000110";
      when "01011111" => BS_out <= "11001111";
      when "01100001" => BS_out <= "11101111";
      when "10001010" => BS_out <= "01111110";
      when "00101001" => BS_out <= "10100101";
      when "00110000" => BS_out <= "00000100";
      when "01100111" => BS_out <= "10000101";
      when "10101100" => BS_out <= "10010001";
      when "11010010" => BS_out <= "10110101";
      when "00100000" => BS_out <= "10110111";
      when "10000101" => BS_out <= "10010111";
      when "01101001" => BS_out <= "11111001";
      when "00000100" => BS_out <= "11110010";
      when "10110100" => BS_out <= "10001101";
      when "01100010" => BS_out <= "10101010";
      when "01101010" => BS_out <= "00000010";
      when "01000111" => BS_out <= "10100000";
      when "00111001" => BS_out <= "00010010";
      when "11010001" => BS_out <= "00111110";
      when "10010011" => BS_out <= "11011100";
      when "10011101" => BS_out <= "01011110";
      when "01110101" => BS_out <= "10011101";
      when "11001111" => BS_out <= "10001010";
      when "00001011" => BS_out <= "00101011";
      when "01111111" => BS_out <= "11010010";
      when "11010011" => BS_out <= "01100110";
      when "00011100" => BS_out <= "10011100";
      when "11111110" => BS_out <= "10111011";
      when "00011110" => BS_out <= "01110010";
      when "10000001" => BS_out <= "00001100";
      when "10001011" => BS_out <= "00111101";
      when "00010110" => BS_out <= "01000111";
      when "10010100" => BS_out <= "00100010";
      when "10110101" => BS_out <= "11010101";
      when "01110011" => BS_out <= "10001111";
      when "11011111" => BS_out <= "10011110";
      when "11111001" => BS_out <= "10011001";
      when "10101010" => BS_out <= "10101100";
      when "10111101" => BS_out <= "01111010";
      when "11000111" => BS_out <= "11000110";
      when "11110010" => BS_out <= "10001001";
      when "01101000" => BS_out <= "01000101";
      when "10010000" => BS_out <= "01100000";
      when "00110001" => BS_out <= "11000111";
      when "01011000" => BS_out <= "01101010";
      when "10000000" => BS_out <= "11001101";
      when "10000100" => BS_out <= "01011111";
      when "10001111" => BS_out <= "01110011";
      when "10110111" => BS_out <= "10101001";
      when "10011000" => BS_out <= "01000110";
      when "01111101" => BS_out <= "11111111";
      when "10000111" => BS_out <= "00010111";
      when "11110101" => BS_out <= "11100110";
      when "11000110" => BS_out <= "10110100";
      when "10110010" => BS_out <= "00110111";
      when "01101011" => BS_out <= "01111111";
      when "01111100" => BS_out <= "00010000";
      when "10110001" => BS_out <= "11001000";
      when "00111011" => BS_out <= "11100010";
      when "01000100" => BS_out <= "00011011";
      when "11111111" => BS_out <= "00010110";
      when "01100110" => BS_out <= "00110011";
      when "01111110" => BS_out <= "11110011";
      when "10100001" => BS_out <= "00110010";
      when "00101101" => BS_out <= "11011000";
      when "01011010" => BS_out <= "10111110";
      when "00111101" => BS_out <= "00100111";
      when "10101101" => BS_out <= "10010101";
      when "10000110" => BS_out <= "01000100";
      when "00010010" => BS_out <= "11001001";
      when "11110001" => BS_out <= "10100001";
      when "01101101" => BS_out <= "00111100";
      when "10011010" => BS_out <= "10111000";
      when "01000110" => BS_out <= "01011010";
      when "01001001" => BS_out <= "00111011";
      when "10100000" => BS_out <= "11100000";
      when "11101110" => BS_out <= "00101000";
      when "11111101" => BS_out <= "01010100";
      when "00001111" => BS_out <= "01110110";
      when "00111010" => BS_out <= "10000000";
      when "11100010" => BS_out <= "10011000";
      when "01110001" => BS_out <= "10100011";
      when "11111000" => BS_out <= "01000001";
      when "11000011" => BS_out <= "00101110";
      when "00010101" => BS_out <= "01011001";
      when "01010011" => BS_out <= "11101101";
      when "01110010" => BS_out <= "01000000";
      when "10111110" => BS_out <= "10101110";
      when "00001110" => BS_out <= "10101011";
      when "00010001" => BS_out <= "10000010";
      when "10001100" => BS_out <= "01100100";
      when "01001010" => BS_out <= "11010110";
      when "10101001" => BS_out <= "11010011";
      when "11001100" => BS_out <= "01001011";
      when "10001101" => BS_out <= "01011101";
      when "11001010" => BS_out <= "01110100";
      when "10001001" => BS_out <= "10100111";
      when "10010001" => BS_out <= "10000001";
      when "11011011" => BS_out <= "10111001";
      when "00010011" => BS_out <= "01111101";
      when "00100101" => BS_out <= "00111111";
      when "01100000" => BS_out <= "11010000";
      when "01001100" => BS_out <= "00101001";
      when "10011111" => BS_out <= "11011011";
      when "11101001" => BS_out <= "00011110";
      when "00001001" => BS_out <= "00000001";
      when "00000111" => BS_out <= "11000101";
      when "01011001" => BS_out <= "11001011";
      when "01111011" => BS_out <= "00100001";
      when "10001000" => BS_out <= "11000100";
      when "10111111" => BS_out <= "00001000";
      when "00101000" => BS_out <= "00110100";
      when "10100111" => BS_out <= "01011100";
      when "10111001" => BS_out <= "01010110";
      when "00000011" => BS_out <= "01111011";
      when "00110010" => BS_out <= "00100011";
      when "01001011" => BS_out <= "10110011";
      when "11110011" => BS_out <= "00001101";
      when "01010111" => BS_out <= "01011011";
      when "11011100" => BS_out <= "10000110";
      when "10010101" => BS_out <= "00101010";
      when "10010110" => BS_out <= "10010000";
      when "01100011" => BS_out <= "11111011";
      when "01100101" => BS_out <= "01001101";
      when "11010111" => BS_out <= "00001110";
      when "01110100" => BS_out <= "10010010";
      when "11001101" => BS_out <= "10111101";
      when "01010101" => BS_out <= "11111100";
      when "01101100" => BS_out <= "01010000";
      when "10100011" => BS_out <= "00001010";
      when "11111100" => BS_out <= "10110000";
      when "10011110" => BS_out <= "00001011";
      when "11011110" => BS_out <= "00011101";
      when "01111000" => BS_out <= "10111100";
      when "10011001" => BS_out <= "11101110";
      when "01000011" => BS_out <= "00011010";
      when "11010110" => BS_out <= "11110110";
      when "00001010" => BS_out <= "01100111";
      when "00110011" => BS_out <= "11000011";
      when "01100100" => BS_out <= "01000011";
      when "00100001" => BS_out <= "11111101";
      when     others => BS_out <= "00000000"; 
    end case;
  end process;
end internals;
