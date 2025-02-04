library ieee;
use ieee.std_logic_1164.all;

entity DECODER_7seg is
	port(C : in  std_logic_vector(1 downto 0);
		 D : out std_logic_vector(6 downto 0));
end DECODER_7seg;

architecture structural of DECODER_7seg is
	
begin	
	D(0) <= (not(C(0)) or C(1));
	D(1) <= C(0);
	D(2) <= C(0);
	D(3) <= C(1);
	D(4) <= C(1);
	D(5) <= (not(C(0)) or C(1));
	D(6) <= C(1);
	
end structural;