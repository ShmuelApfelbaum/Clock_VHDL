library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity bin_to_BCD is
port 
(
binary_in: in std_logic_vector (5 downto 0);
MS_digit: out std_logic_vector (3 downto 0);
LS_digit: out std_logic_vector (3 downto 0)
);
end bin_to_BCD;

architecture conv_arc of bin_to_BCD is
  signal bcd: std_logic_vector (7 downto 0);


begin
  with binary_in select
	bcd <=  x"0" & x"0" when "000000",
			x"0" & x"1" when "000001",
			x"0" & x"2" when "000010",
			x"0" & x"3" when "000011",
			x"0" & x"4" when "000100",
			x"0" & x"5" when "000101",
			x"0" & x"6" when "000110",
			x"0" & x"7" when "000111",
			x"0" & x"8" when "001000",
			x"0" & x"9" when "001001",
			x"1" & x"0" when "001010",
			x"1" & x"1" when "001011",
			x"1" & x"2" when "001100",
			x"1" & x"3" when "001101",
			x"1" & x"4" when "001110",
			x"1" & x"5" when "001111",
			x"1" & x"6" when "010000",
			x"1" & x"7" when "010001",
			x"1" & x"8" when "010010",
			x"1" & x"9" when "010011",
			x"2" & x"0" when "010100",
			x"2" & x"1" when "010101",
			x"2" & x"2" when "010110",
			x"2" & x"3" when "010111",
			x"2" & x"4" when "011000",
			x"2" & x"5" when "011001",
			x"2" & x"6"	when "011010",
			x"2" & x"7" when "011011",
			x"2" & x"8" when "011100",
			x"2" & x"9" when "011101",
			x"3" & x"0" when "011110",
			x"3" & x"1" when "011111",
			x"3" & x"2" when "100000",
			x"3" & x"3" when "100001",
			x"3" & x"4" when "100010",
			x"3" & x"5" when "100011",
			x"3" & x"6" when "100100",
			x"3" & x"7" when "100101",
			x"3" & x"8" when "100110",
			x"3" & x"9" when "100111",
			x"4" & x"0" when "101000",
			x"4" & x"1" when "101001",
			x"4" & x"2" when "101010",
			x"4" & x"3" when "101011",
			x"4" & x"4" when "101100",
			x"4" & x"5" when "101101",
			x"4" & x"6" when "101110",
			x"4" & x"7" when "101111",
			x"4" & x"8" when "110000",
			x"4" & x"9" when "110001",
			x"5" & x"0" when "110010",
			x"5" & x"1" when "110011",
			x"5" & x"2" when "110100",
			x"5" & x"3" when "110101",
			x"5" & x"4" when "110110",
			x"5" & x"5" when "110111",
			x"5" & x"6" when "111000",
			x"5" & x"7" when "111001",
			x"5" & x"8" when "111010",
			x"5" & x"9" when "111011",
			"XXXXXXXX"  when OTHERS;
			
  MS_digit <= bcd(7 downto 4);
  LS_digit <= bcd(3 downto 0);

end conv_arc;