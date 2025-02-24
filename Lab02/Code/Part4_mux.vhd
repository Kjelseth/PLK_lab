library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
	port(Sel   : in  std_logic;
		 In_A  : in  std_logic_vector(3 downto 0);
		 In_B  : in  std_logic_vector(3 downto 0);
		 Out_M : out std_logic_vector(3 downto 0));
end mux2to1;

architecture strucural of mux2to1 is

begin

	Out_M(0) <= (((not Sel) and In_A(0)) or
				(Sel and  In_B(0)));
	Out_M(1) <= (((not Sel) and In_A(1)) or
				(Sel and  In_B(1)));
	Out_M(2) <= (((not Sel) and In_A(2)) or
				(Sel and  In_B(2)));
	Out_M(3) <= (((not Sel) and In_A(3)) or
				(Sel and  In_B(3)));

end strucural;