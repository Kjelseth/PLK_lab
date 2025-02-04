library ieee;
use ieee.std_logic_1164.all;

entity L01P04 is
	port(SW   : in  std_logic_vector(1 downto 0);
		 HEX0 : out std_logic_vector(6 downto 0));
end L01P04;

architecture structural of L01P04 is
	signal c : std_logic_vector(1 downto 0);
	
begin
	c <= SW;
	
	HEX0(0) <= (not(c(0)) or c(1));
	HEX0(1) <= c(0);
	HEX0(2) <= c(0);
	HEX0(3) <= c(1);
	HEX0(4) <= c(1);
	HEX0(5) <= (not(c(0)) or c(1));
	HEX0(6) <= c(1);
	
end structural;