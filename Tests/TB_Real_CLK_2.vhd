library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity TB_Real_CLK_2 is
end TB_Real_CLK_2;

architecture TB_ARC_2 of TB_Real_CLK_2 is
component REAL_CLK
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
end component;
	
signal tb_C: std_logic:= '0';
signal tb_R: std_logic;
signal tb_D: std_logic_vector(5 downto 0);
signal tb_A: std_logic_vector(1 downto 0);
signal tb_L: std_logic;
signal tb_TEST: std_logic:= '1';
signal tb_B_SEL: std_logic_vector(3 downto 0);
signal tb_SSD_SEL: std_logic; 
signal tb_B_OUT: std_logic_vector(6 downto 0);
signal tb_SSD_OUT: std_logic_vector(6 downto 0);

begin 
DUT: REAL_CLK
	port map(tb_C, tb_R, tb_D, tb_A, tb_L, tb_TEST, tb_B_SEL, tb_SSD_SEL, tb_B_OUT, tb_SSD_OUT);
	
	
	tb_R <= '1',
			'0' after 13 ns;
	
	tb_C <= not(tb_C) after 5 ns;
	
	tb_D <= "000000" after 2000 us,
			"111010" after 2000.1 us,
			"010111" after 2000.2 us;
	
	tb_A <= "10",
			"01" after 2000.1 us,
			"00" after 2000.2 us;
	
	tb_L <= '0',
			'1' after 2000 us,
			'0' after 2000.3 us;
	
	
end TB_ARC_2;
