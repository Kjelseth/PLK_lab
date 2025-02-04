library ieee;
use ieee.std_logic_1164.all;

entity MUX_2bit_4to1 is
	port(S, U, V, W, X : in  std_logic_vector(1 downto 0);
		 M			   : out std_logic_vector(1 downto 0));
end MUX_2bit_4to1;

architecture structural of MUX_2bit_4to1 is

	signal A : std_logic_vector(1 downto 0);
	signal B : std_logic_vector(1 downto 0);

begin
	A(0) <= (not S(0) and U(0)) or (S(0) and V(0));
	A(1) <= (not S(0) and U(1)) or (S(0) and V(1));
	B(0) <= (not S(0) and W(0)) or (S(0) and X(0));
	B(1) <= (not S(0) and W(1)) or (S(0) and X(1));
	
	M(0) <= (not S(1) and A(0)) or (S(1) and B(0));
	M(1) <= (not S(1) and A(1)) or (S(1) and B(1));
	
end structural;