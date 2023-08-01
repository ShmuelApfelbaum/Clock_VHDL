Library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity REAL_CLK is
port
(
	CLK:    	 	 in  std_logic;
	RESET:  	 	 in  std_logic;
	DATA_IN:	 in std_logic_vector(5 downto 0);
	ADRS: 		 in std_logic_vector(1 downto 0);
	LOAD: 		 in  std_logic;
	TESTMODE: 	 	 in std_logic;
	B_DIGIT_SELECT:  out std_logic_vector(3 downto 0);
	DIGIT_SELECT:    out  std_logic;
	B_SSD_OUT:	 	 out std_logic_vector(6 downto 0);
	SSD_OUT:	 	 out std_logic_vector(6 downto 0)
);
end REAL_CLK;
architecture REAL_CLK_ARC of REAL_CLK is

component BASIC_CLK
port
(
	CLK:    	 in  std_logic;
	RESET:  	 in  std_logic;
	DATA_IN:	 in std_logic_vector(5 downto 0);
	ADRS: 		 in std_logic_vector(1 downto 0);
	LOAD: 		 in  std_logic;
	TESTMODE: 	 in std_logic;
	SECONDS:     out std_logic_vector(5 downto 0);
	MINUTES:     out std_logic_vector(5 downto 0);
	HOURS:     	 out std_logic_vector(4 downto 0)
);
end component;

component bin_to_BCD
port 
(
	binary_in: in std_logic_vector (5 downto 0);
	MS_digit: out std_logic_vector (3 downto 0);
	LS_digit: out std_logic_vector (3 downto 0)
);
end component;

component bcd_to_SSD
port 
(
	BCD: in std_logic_vector(3 downto 0);
	SSD: out std_logic_vector(6 downto 0)
);
end component;

-- signals

--- binary
signal BIN_SECONDS: std_logic_vector(5 downto 0);
signal BIN_MINUTES: std_logic_vector(5 downto 0);
signal HOURS: 		std_logic_vector(4 downto 0);
signal BIN_HOURS: 	std_logic_vector(5 downto 0);

--- bcd
signal BCD_MS_SECONDS: std_logic_vector(3 downto 0);
signal BCD_LS_SECONDS: std_logic_vector(3 downto 0);
signal BCD_MS_MINUTES: std_logic_vector(3 downto 0);
signal BCD_LS_MINUTES: std_logic_vector(3 downto 0);
signal BCD_MS_HOURS:   std_logic_vector(3 downto 0);
signal BCD_LS_HOURS:   std_logic_vector(3 downto 0);

--- ssd
signal SSD_MS_SECONDS: std_logic_vector(6 downto 0);
signal SSD_LS_SECONDS: std_logic_vector(6 downto 0);
signal SSD_MS_MINUTES: std_logic_vector(6 downto 0);
signal SSD_LS_MINUTES: std_logic_vector(6 downto 0);
signal SSD_MS_HOURS:   std_logic_vector(6 downto 0);
signal SSD_LS_HOURS:   std_logic_vector(6 downto 0);

--- Internal Counter
signal IN_COUNTER: std_logic_vector(18 downto 0);

begin

--- chenge hours to 6 bit
BIN_HOURS <= '0' & HOURS;

--- connecting all components


PORTMAP0: BASIC_CLK  port map (CLK, RESET, DATA_IN, ADRS, LOAD, TESTMODE, BIN_SECONDS, BIN_MINUTES, HOURS);

--- BIN TO BCD

PORTMAP1: bin_to_BCD port map (BIN_SECONDS, BCD_MS_SECONDS, BCD_LS_SECONDS);
PORTMAP2: bin_to_BCD port map (BIN_MINUTES, BCD_MS_MINUTES, BCD_LS_MINUTES);
PORTMAP3: bin_to_BCD port map (BIN_HOURS, BCD_MS_HOURS, BCD_LS_HOURS);

--- BCD TO SSD

PORTMAP4: bcd_to_SSD port map (BCD_MS_SECONDS, SSD_MS_SECONDS);
PORTMAP5: bcd_to_SSD port map (BCD_LS_SECONDS, SSD_LS_SECONDS);
PORTMAP6: bcd_to_SSD port map (BCD_MS_MINUTES, SSD_MS_MINUTES);
PORTMAP7: bcd_to_SSD port map (BCD_LS_MINUTES, SSD_LS_MINUTES);
PORTMAP8: bcd_to_SSD port map (BCD_MS_HOURS, SSD_MS_HOURS);
PORTMAP9: bcd_to_SSD port map (BCD_LS_HOURS, SSD_LS_HOURS);

process
begin
wait until rising_edge(CLK);
	if (RESET= '1') then
		IN_COUNTER <= "0000000000000000000";
	else
		if (TESTMODE = '1') then
			IN_COUNTER(18 downto 17) <= IN_COUNTER(18 downto 17) + 1;
		else
			IN_COUNTER <= IN_COUNTER + 1;
		end if;
	end if;
end process;


process(SSD_MS_MINUTES, SSD_LS_MINUTES, SSD_MS_HOURS, SSD_LS_HOURS, IN_COUNTER)
begin
	case IN_COUNTER(18 downto 17) is
		when "00" =>   
			B_SSD_OUT <= SSD_MS_HOURS; 
			B_DIGIT_SELECT <= "0111";
		when "01" =>   
			B_SSD_OUT <= SSD_LS_HOURS; 
			B_DIGIT_SELECT <= "1011";
		when "10" =>
			B_SSD_OUT <= SSD_MS_MINUTES; 
			B_DIGIT_SELECT <= "1101";
		when "11" =>
			B_SSD_OUT <= SSD_LS_MINUTES; 
			B_DIGIT_SELECT <= "1110";
		when others =>
			B_SSD_OUT <= (others => 'X');
			B_DIGIT_SELECT <= (others => 'X');
	end case;
end process;


process(SSD_MS_SECONDS, SSD_LS_SECONDS, IN_COUNTER)
begin
	case IN_COUNTER(18) is
		when '0' =>   
			SSD_OUT <= not(SSD_LS_SECONDS); 
			DIGIT_SELECT <= '0';
		when '1' =>   
			SSD_OUT <= not(SSD_MS_SECONDS); 
			DIGIT_SELECT <= '1';
		when others =>
			SSD_OUT <= (others => 'X');
			DIGIT_SELECT <= 'X';
	end case;
end process;

end REAL_CLK_ARC;



