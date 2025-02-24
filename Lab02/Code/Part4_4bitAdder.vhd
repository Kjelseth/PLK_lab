library ieee;
use ieee.std_logic_1164.all;

entity adder4bit is
	port(Ci : in  std_logic;
		 a  : in  std_logic_vector(3 downto 0);
		 b  : in  std_logic_vector(3 downto 0);
		 S  : out std_logic_vector(3 downto 0);
		 Co : out std_logic);
end adder4bit;


architecture strucural of adder4bit is

	component fullAdder
		port(C_in  : in  std_logic;
			 U     : in  std_logic;
			 V     : in  std_logic;
			 S_out : out std_logic;
			 C_out : out std_logic);
	end component;

	signal C : std_logic_vector(2 downto 0);

begin

	A0: fullAdder port map
		(C_in => Ci,
		 U => a(0),
		 V => b(0),
		 S_out => S(0),
		 C_out => C(0));
	
	A1: fullAdder port map
		(C_in => C(0),
		 U => a(1),
		 V => b(1),
		 S_out => S(1),
		 C_out => C(1));
		 	
	A2: fullAdder port map
		(C_in => C(1),
		 U => a(2),
		 V => b(2),
		 S_out => S(2),
		 C_out => C(2));
		 	
	A3: fullAdder port map
		(C_in => C(2),
		 U => a(3),
		 V => b(3),
		 S_out => S(3),
		 C_out => Co);

end strucural;