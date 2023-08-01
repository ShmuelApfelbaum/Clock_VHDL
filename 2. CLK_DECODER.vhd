Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

Entity CLK_DECODER is
port
	(
		ADRS: in std_logic_vector(1 downto 0);
		SEL_HOURS, SEL_MINUTES, SEL_SECONDS: out std_logic
	);
end CLK_DECODER;

architecture DECODER_ARC of CLK_DECODER is
begin

	SEL_HOURS <= '1' when (ADRS = "00") else '0';
	SEL_MINUTES <= '1' when (ADRS = "01") else '0';
	SEL_SECONDS <= '1' when (ADRS = "10") else '0';

end DECODER_ARC;
