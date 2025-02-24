library ieee;
use ieee.std_logic_1164.all;

entity L02P03 is
	port(SW   : in  std_logic_vector(8 downto 0);
		 LEDR : out std_logic_vector(4 downto 0));
end L02P03;


architecture strucural of L02P03 is

	component fullAdder
		port(Ci : in  std_logic;
			 A  : in  std_logic;
			 B  : in  std_logic;
			 S  : out std_logic;
			 Co : out std_logic);
	end component;

	signal C : std_logic_vector(2 downto 0);

begin

	A0: fullAdder port map
		(Ci => SW(8),
		 A => SW(0),
		 B => SW(4),
		 S => LEDR(0),
		 Co => C(0));
	
	A1: fullAdder port map
		(Ci => C(0),
		 A => SW(1),
		 B => SW(5),
		 S => LEDR(1),
		 Co => C(1));
		 	
	A2: fullAdder port map
		(Ci => C(1),
		 A => SW(2),
		 B => SW(6),
		 S => LEDR(2),
		 Co => C(2));
		 	
	A3: fullAdder port map
		(Ci => C(2),
		 A => SW(3),
		 B => SW(7),
		 S => LEDR(3),
		 Co => LEDR(4));

end strucural;