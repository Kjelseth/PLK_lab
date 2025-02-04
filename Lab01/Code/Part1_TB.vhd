library ieee;
use ieee.std_logic_1164.all;

entity L01P01TB is
end L01P01TB;

architecture behaviour of L01P01TB is

	component L01P01
		port(SW   : in  std_logic_vector(9 downto 0);
		     LEDR : out std_logic_vector(9 downto 0));
	end component;

	signal SW_s   : std_logic_vector(9 downto 0);
	signal LEDR_s : std_logic_vector(9 downto 0);

begin
	vectors: process begin
		SW_s <= "0000000000";
		wait for 20 ns;
		SW_s <= "0101010101";
		wait for 20 ns;
		SW_s <= "1111111111";
		wait for 20 ns;
		SW_s <= "1010101010";
		wait for 20 ns;
		SW_s <= "1111100000";
		wait for 20 ns;
		SW_s <= "0000011111";
		wait for 20 ns;
		SW_s <= "1100110011";
		wait for 20 ns;
		SW_s <= "0011001100";
		wait;
	end process;

	U1: L01P01 port map (SW_s, LEDR_s);
end behaviour;