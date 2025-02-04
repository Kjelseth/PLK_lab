library ieee;
use ieee.std_logic_1164.all;

entity L01P03TB is
end L01P03TB;

architecture behaviour of L01P03TB is
	
	component L01P03
		port(SW   : in  std_logic_vector(9 downto 0);
			 LEDR : out std_logic_vector(1 downto 0));
	end component;
	
	signal Sel : std_logic_vector(1 downto 0);
	signal U   : std_logic_vector(1 downto 0);
	signal V   : std_logic_vector(1 downto 0);
	signal W   : std_logic_vector(1 downto 0);
	signal X   : std_logic_vector(1 downto 0);
	signal LED : std_logic_vector(1 downto 0);
	
begin
	vectors: process begin
		U <= "00"; V <= "00"; W <= "00"; X <= "00";
		Sel <= "00";
		wait for 20 ns;
		U <= "11"; V <= "10"; W <= "01"; X <= "00";
		Sel <= "01";
		wait for 20 ns;
		Sel <= "10";
		wait for 20 ns;
		Sel <= "11";
		wait for 20 ns;
		U <= "11"; V <= "00"; W <= "11"; X <= "11";
		Sel <= "01";
		wait for 20 ns;
		U <= "00"; V <= "11"; W <= "00"; X <= "00";
		wait for 20 ns;
		Sel <= "10";
		wait for 20 ns;
		U <= "11"; V <= "11"; W <= "11"; X <= "11";
		Sel <= "11";
		wait;
	end process;
	
	U1: L01P03 port map
		(SW(9 downto 8) => Sel,
		 SW(7 downto 6) => U,
		 SW(5 downto 4) => V,
		 SW(3 downto 2) => W,
		 SW(1 downto 0) => X,
		 LEDR => LED);
		 
end behaviour;