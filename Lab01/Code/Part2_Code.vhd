library ieee;
use ieee.std_logic_1164.all;

entity L01P02 is
	port(SW   : in  std_logic_vector(9 downto 0);
	     LEDR : out std_logic_vector(9 downto 0));
end L01P02;

architecture structural of L01P02 is
begin
	LEDR(9) <= SW(9);
	LEDR(8 downto 4) <= "00000";
	LEDR(3) <= (not(SW(9)) and SW(3)) or (SW(9) and SW(7));
	LEDR(2) <= (not(SW(9)) and SW(2)) or (SW(9) and SW(6));
	LEDR(1) <= (not(SW(9)) and SW(1)) or (SW(9) and SW(5));
	LEDR(0) <= (not(SW(9)) and SW(0)) or (SW(9) and SW(4));
end structural;