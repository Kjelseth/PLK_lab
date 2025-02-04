library ieee;
use ieee.std_logic_1164.all;

entity L01P02TB is
end L01P02TB;

architecture behaviour of L01P02TB is

	component L01P02
		port(SW   : in  std_logic_vector(9 downto 0);
		     LEDR : out std_logic_vector(9 downto 0));
	end component;

	signal A    : std_logic_vector(3 downto 0);
	signal B    : std_logic_vector(3 downto 0);
	signal Sel  : std_logic;
	signal flag : std_logic;
	signal na   : std_logic_vector(4 downto 0);
	signal Y    : std_logic_vector(3 downto 0);

begin
	vectors: process begin
		A <= X"0"; B <= X"0"; Sel <= '0';
		wait for 20 ns;
		A <= X"F"; B <= X"4"; Sel <= '0';
		wait for 20 ns;
		A <= X"0"; B <= X"F"; Sel <= '0';
		wait for 20 ns;
		A <= X"F"; B <= X"0"; Sel <= '1';
		wait for 20 ns;
		A <= X"0"; B <= X"F"; Sel <= '1';
		wait for 20 ns;
		A <= X"A"; B <= X"7"; Sel <= '1';
		wait for 20 ns;
		A <= X"3"; B <= X"D"; Sel <= '0';
		wait for 20 ns;
		A <= X"7"; B <= X"9"; Sel <= '1';
		wait for 20 ns;
		A <= X"B"; B <= X"0"; Sel <= '1';
		wait;
	end process;

	U1: L01P02 port map
		(SW(9) => Sel,
		 SW(8) => '0',
		 SW(7 downto 4) => B,
		 SW(3 downto 0) => A,
		 LEDR(9) => flag,
		 LEDR(8 downto 4) => na,
		 LEDR(3 downto 0) => Y);
end behaviour;