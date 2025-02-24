library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
	port(s : in  std_logic;
		 U : in  std_logic_vector(3 downto 0);
		 V : in  std_logic_vector(3 downto 0);
		 M : out std_logic_vector(3 downto 0));
end mux2to1;

architecture strucural of mux2to1 is

begin

	M(0) <= (((not s) and U(0)) or (s and  V(0)));
	M(1) <= (((not s) and U(1)) or (s and  V(1)));
	M(2) <= (((not s) and U(2)) or (s and  V(2)));
	M(3) <= (((not s) and U(3)) or (s and  V(3)));

end strucural;