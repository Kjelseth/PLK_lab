library ieee;
use ieee.std_logic_1164.all;

-- This is an example of VHDL
entity Example is
	port(SW   : in  std_logic_vector(9 downto 0);
	     LEDR : out std_logic_vector(0 to 9));
end Example;

architecture structural of Example is
	signal a : std_logic;
	signal b : std_logic;
begin
	a <= ((SW(9) or SW(8)) and (SW(8) or SW(7)));
	b <= ((SW(9) and SW(6)) or (SW(6) and SW(7)));	
	LEDR(0) <= ((a and b) and SW(0));
	LEDR(1) <= ((a or b) and SW(1));
	LEDR(2) <= ((a nand b) and SW(2));
	LEDR(3) <= ((a nor b) and SW(3));
	LEDR(4) <= ((a xor b) and SW(4));
	LEDR(5) <= ((a xor b) and SW(5));
	LEDR(6 to 8) <= "000";
	LEDR(9) <= '1'; --This LED signifies power on
end structural;