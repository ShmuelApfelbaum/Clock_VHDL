library IEEE;
  use IEEE.std_logic_1164.all;
  
entity bcd_to_SSD is
port 
(
	BCD: in std_logic_vector(3 downto 0);
	SSD: out std_logic_vector(6 downto 0)
);
end bcd_to_SSD;

architecture bcd_to_SSD_ARC of bcd_to_SSD is
begin

	process(BCD)
	begin
		case BCD is 
			when "0000" => SSD <= "0000001";--0
			when "0001" => SSD <= "1001111";--1
			when "0010" => SSD <= "0010010";--2
			when "0011" => SSD <= "0000110";--3
			when "0100" => SSD <= "1001100";--4
			when "0101" => SSD <= "0100100";--5
			when "0110" => SSD <= "0100000";--6
			when "0111" => SSD <= "0001111";--7
			when "1000" => SSD <= "0000000";--8
			when "1001" => SSD <= "0000100";--9
			when others => SSD <= "XXXXXXX";
		end case;
	end process;

end bcd_to_SSD_ARC;


