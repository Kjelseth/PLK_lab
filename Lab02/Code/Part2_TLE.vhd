library ieee;
use ieee.std_logic_1164.all;

entity L02P02 is
	port(SW   : in  std_logic_vector(3 downto 0);
		 HEX0 : out std_logic_vector(6 downto 0);
		 HEX1 : out std_logic_vector(6 downto 0));
end L02P02;


architecture strucural of L02P02 is

	component decoder7seg
		port(BCD : in  std_logic_vector(3 downto 0);
			 HEX : out std_logic_vector(6 downto 0));
	end component;
	
	component mux2to1
		port(s : in  std_logic;
			 U : in  std_logic_vector(3 downto 0);
			 V : in  std_logic_vector(3 downto 0);
			 M : out std_logic_vector(3 downto 0));
	end component;
	
	signal d0 : std_logic_vector(3 downto 0);
	signal Z  : std_logic_vector(3 downto 0);
	signal A  : std_logic_vector(3 downto 0);

begin

	-- Comparator number is 4 bit because of decoder
	Z(0) <= ((SW(3) and SW(1)) or (SW(3) and SW(2)));
	Z(3 downto 1) <= "000";

	-- Circut A to convert to correct zeroth digit
	A(0) <= SW(0);
	A(1) <= (not SW(1));
	A(2) <= (SW(2) and SW(1));
	A(3) <= '0';

	M0: mux2to1 port map
		(s => z(0),
		 U => SW,
		 V => A,
		 M => d0);

	H0: decoder7seg port map
		(BCD => d0,
		 HEX => HEX0);
		 
	H1: decoder7seg port map
		(BCD => Z,
		 HEX => HEX1);

end strucural;