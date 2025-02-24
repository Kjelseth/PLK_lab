library ieee;
use ieee.std_logic_1164.all;

entity decoder7seg is
	port(BCD : in  std_logic_vector(3 downto 0);
		 HEX : out std_logic_vector(6 downto 0));
end decoder7seg;

architecture strucural of decoder7seg is

	signal a : std_logic;
	signal b : std_logic;
	signal c : std_logic;
	signal d : std_logic;

begin

	a <= BCD(3);
	b <= BCD(2);
	c <= BCD(1);
	d <= BCD(0);

	HEX(0) <= (((not a) and (not b) and (not c) and d) or
			  (b and (not d)));
	HEX(1) <= ((b and (not c) and d) or
			  (b and c and (not d)));
	HEX(2) <= ((not b) and c and (not d));
	HEX(3) <= (((not b) and (not c) and d) or
			  (b and (not c) and (not d)) or (b and c and d));
	HEX(4) <= ((b and (not c)) or d);
	HEX(5) <= (((not a) and (not b) and d) or
			  ((not b) and c) or (c and d));
	HEX(6) <= (((not a) and (not b) and (not c)) or
			  (b and c and d));

end strucural;