library ieee;
use ieee.std_logic_1164.all;

entity L01P03 is
	port(SW   : in  std_logic_vector(9 downto 0);
		 LEDR : out std_logic_vector(1 downto 0));
end L01P03;

architecture structural of L01P03 is
	signal s : std_logic_vector(1 downto 0);
	signal u : std_logic_vector(1 downto 0);
	signal v : std_logic_vector(1 downto 0);
	signal w : std_logic_vector(1 downto 0);
	signal x : std_logic_vector(1 downto 0);
	signal a : std_logic_vector(1 downto 0);
	signal b : std_logic_vector(1 downto 0);
	signal m : std_logic_vector(1 downto 0);

begin
	s <= SW(9 downto 8);
	u <= SW(7 downto 6);
	v <= SW(5 downto 4);
	w <= SW(3 downto 2);
	x <= SW(1 downto 0);
	
	a(0) <= (not s(0) and u(0)) or (s(0) and v(0));
	a(1) <= (not s(0) and u(1)) or (s(0) and v(1));
	b(0) <= (not s(0) and w(0)) or (s(0) and x(0));
	b(1) <= (not s(0) and w(1)) or (s(0) and x(1));
	
	m(0) <= (not s(1) and a(0)) or (s(1) and b(0));
	m(1) <= (not s(1) and a(1)) or (s(1) and b(1));
	
	LEDR <= m;
end structural;