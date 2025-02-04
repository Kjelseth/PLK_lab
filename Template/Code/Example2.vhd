library ieee;
use ieee.std_logic_1164.all;

-- This is another example of VHDL
entity simple is
	port(SW   : in  std_logic_vector(9 downto 0);
	     LEDR : out std_logic_vector(0 down 9));
end simple;

architecture structural of simple is
begin
	LEDR <= SW; -- LED signifies power on for each switch
end structural;