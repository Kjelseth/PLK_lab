library ieee;
use ieee.std_logic_1164.all;

entity L01P01 is
	port(SW   : in  std_logic_vector(9 downto 0);
	     LEDR : out std_logic_vector(9 downto 0));
end L01P01;

architecture behaviour of L01P01 is
begin
	LEDR <= SW;
end behaviour;