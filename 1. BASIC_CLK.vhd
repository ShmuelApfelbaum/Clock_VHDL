library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity BASIC_CLK is
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
end BASIC_CLK;

architecture BASIC_CLK_ARC of BASIC_CLK is
signal Q:           std_logic_vector(26 downto 0);
signal CONST:       std_logic_vector(26 downto 0);
signal TC_TIMEBASE: std_logic;
signal Q_SECONDS :  std_logic_vector(5 downto 0);
signal Q_MINUTES :  std_logic_vector(5 downto 0);
signal Q_HOURS :    std_logic_vector(4 downto 0);
--signals for decoder
signal SEL_HOURS:   std_logic;
signal SEL_MINUTES: std_logic;
signal SEL_SECONDS: std_logic;


component CLK_DECODER
port
	(
		ADRS: in std_logic_vector(1 downto 0);
		SEL_HOURS, SEL_MINUTES, SEL_SECONDS: out std_logic
	);
end component;

begin

PORTMAP: CLK_DECODER port map (ADRS, SEL_HOURS, SEL_MINUTES, SEL_SECONDS);

  CONST <= "000000000000000000000001001" when (TESTMODE = '1') else "101111101011110000011111111";

--Time base generator
P1: process
begin
    wait until rising_edge(CLK);
    if (RESET = '1') then
      Q <= (others => '0');
    else
		if (Q < CONST) then
			Q <= Q + 1;
		else
			Q <= (others => '0');
		end if;
    end if;
end process;

TC_TIMEBASE <= '1' when (Q = 0) else '0';

--Seconds
P2: process
begin
	wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_SECONDS <= (others => '0');
		else
			if ((LOAD = '1') and (SEL_SECONDS = '1')) then
				Q_SECONDS <= DATA_IN;
			else
				if (TC_TIMEBASE = '1') then
					if (Q_SECONDS < 59) then
						Q_SECONDS <= Q_SECONDS + 1;
					else
						Q_SECONDS <= (others => '0');
					end if;
				end if;
			end if;
		end if;
end process;

SECONDS <= Q_SECONDS;

--Minutes
P3: process
begin
	wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_MINUTES <= (others => '0');
		else
			if ((LOAD = '1') and (SEL_MINUTES = '1')) then
				Q_MINUTES <= DATA_IN;
			else
				if ((TC_TIMEBASE = '1') and (Q_SECONDS = 59)) then
					if (Q_MINUTES < 59) then
						Q_MINUTES <= Q_MINUTES + 1;
					else
						Q_MINUTES <= (others => '0');
					end if;
				end if;
			end if;
		end if;
end process;

MINUTES <= Q_MINUTES;

--Hours
P4: process
begin
	wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_HOURS <= (others => '0');
		else
			if ((LOAD = '1') and (SEL_HOURS = '1')) then
				Q_HOURS <= DATA_IN(4 downto 0);
			else
				if ((TC_TIMEBASE = '1') and (Q_MINUTES = 59) and (Q_SECONDS = 59)) then
					if (Q_HOURS < 23) then
						Q_HOURS <= Q_HOURS + 1;
					else
						Q_HOURS <= (others => '0');
					end if;
				end if;
			end if;
		end if;
end process;

HOURS <= Q_HOURS;

end BASIC_CLK_ARC;
