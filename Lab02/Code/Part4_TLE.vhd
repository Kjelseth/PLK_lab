library ieee;
use ieee.std_logic_1164.all;

entity L02P04 is
	port(SW   : in  std_logic_vector(8 downto 0);
		 LEDR : out std_logic_vector(9 downto 0);
		 HEX0 : out std_logic_vector(6 downto 0);
		 HEX1 : out std_logic_vector(6 downto 0);
		 HEX3 : out std_logic_vector(6 downto 0);
		 HEX5 : out std_logic_vector(6 downto 0));
end L02P04;


architecture strucural of L02P04 is

	component adder4bit
		port(Ci : in  std_logic;
			 a  : in  std_logic_vector(3 downto 0);
			 b  : in  std_logic_vector(3 downto 0);
			 S  : out std_logic_vector(3 downto 0);
			 Co : out std_logic);
	end component;

	component mux2to1
		port(Sel   : in  std_logic;
			 In_A  : in  std_logic_vector(3 downto 0);
			 In_B  : in  std_logic_vector(3 downto 0);
			 Out_M : out std_logic_vector(3 downto 0));
	end component;

	component decoder7seg
		port(BCD : in  std_logic_vector(3 downto 0);
			 HEX : out std_logic_vector(6 downto 0));
	end component;

	signal Sum : std_logic_vector(4 downto 0);
	signal S0  : std_logic_vector(3 downto 0);
	signal S1  : std_logic_vector(3 downto 0);
	signal X   : std_logic_vector(3 downto 0);
	signal Y   : std_logic_vector(3 downto 0);
	signal T   : std_logic_vector(3 downto 0);

begin
	
	X <= SW(7 downto 4);
	Y <= SW(3 downto 0);
	LEDR(8 downto 5) <= "0000";
	LEDR(4 downto 0) <= Sum;
	
	-- Checking whether X or Y is above 9
	LEDR(9) <= ((X(3) and X(1)) or (X(3) and X(2)) or
				(Y(3) and Y(1)) or (Y(3) and Y(2)));
	
	-- Checking whether Sum is above 9
	S1(0) <= ((Sum(3) and Sum(1)) or (Sum(3) and Sum(2)) or sum(4));
	S1(3 downto 1) <= "000"; -- S1 only displays 0 or 1
	
	-- Value to pass to S1 when above 9
	T(0) <= Sum(0);
	T(1) <= (not Sum(1));
	T(2) <= ((Sum(2) and Sum(1)) or (Sum(4) and (not Sum(1))));
	T(3) <= (Sum(4) and Sum(1));

	A0: adder4bit port map
		(Ci => SW(8),
		 a => SW(3 downto 0),
	 	 b => SW(7 downto 4),
		 S => Sum(3 downto 0),
		 Co => Sum(4));
	
	M0: mux2to1 port map
		(Sel => S1(0),
		 In_A => Sum(3 downto 0),
		 In_B => T,
		 Out_M => S0);
	
	H0: decoder7seg port map
		(BCD => S0,
		 HEX => HEX0);	
		 
	H1: decoder7seg port map
		(BCD => S1,
		 HEX => HEX1);	
	
	H3: decoder7seg port map
		(BCD => Y,
		 HEX => HEX3);	
		 
	H5: decoder7seg port map
		(BCD => X,
		 HEX => HEX5);
	
end strucural;