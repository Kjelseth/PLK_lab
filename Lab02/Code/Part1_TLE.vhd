library ieee;
use ieee.std_logic_1164.all;

entity L02P01 is
	port(SW   : in  std_logic_vector(7 downto 0);
		 HEX0 : out std_logic_vector(6 downto 0);
		 HEX1 : out std_logic_vector(6 downto 0));
end L02P01;


architecture strucural of L02P01 is

	signal a0 : std_logic;
	signal b0 : std_logic;
	signal c0 : std_logic;
	signal d0 : std_logic;
	signal a1 : std_logic;
	signal b1 : std_logic;
	signal c1 : std_logic;
	signal d1 : std_logic;

begin

	a0 <= SW(3);
	b0 <= SW(2);
	c0 <= SW(1);
	d0 <= SW(0);
	a1 <= SW(7);
	b1 <= SW(6);
	c1 <= SW(5);
	d1 <= SW(4);

	HEX0(0) <= (((not a0) and (not b0) and (not c0) and d0) or
				(b0 and (not d0)));
	HEX0(1) <= ((b0 and (not c0) and d0) or
				(b0 and c0 and (not d0)));
	HEX0(2) <= ((not b0) and c0 and (not d0));
	HEX0(3) <= (((not b0) and (not c0) and d0) or
				(b0 and (not c0) and (not d0)) or
				(b0 and c0 and d0));
	HEX0(4) <= ((b0 and (not c0)) or d0);
	HEX0(5) <= (((not a0) and (not b0) and d0) or
				((not b0) and c0) or
				(c0 and d0));
	HEX0(6) <= (((not a0) and (not b0) and (not c0)) or
				(b0 and c0 and d0));

	HEX1(0) <= (((not a1) and (not b1) and (not c1) and d1) or
				(b1 and (not d1)));
	HEX1(1) <= ((b1 and (not c1) and d1) or
				(b1 and c1 and (not d1)));
	HEX1(2) <= ((not b1) and c1 and (not d1));
	HEX1(3) <= (((not b1) and (not c1) and d1) or
				(b1 and (not c1) and (not d1)) or
				(b1 and c1 and d1));
	HEX1(4) <= ((b1 and (not c1)) or d1);
	HEX1(5) <= (((not a1) and (not b1) and d1) or
				((not b1) and c1) or
				(c1 and d1));
	HEX1(6) <= (((not a1) and (not b1) and (not c1)) or
				(b1 and c1 and d1));

end strucural;