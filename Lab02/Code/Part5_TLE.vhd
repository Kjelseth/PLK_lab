library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity L02P05 is
	port(SW   : in  std_logic_vector(8 downto 0);
		 HEX0 : out std_logic_vector(6 downto 0);
		 HEX1 : out std_logic_vector(6 downto 0);
		 HEX3 : out std_logic_vector(6 downto 0);
		 HEX5 : out std_logic_vector(6 downto 0));
end L02P05;


architecture behavioural of L02P05 is

	component decoder7seg
		port(BCD : in  std_logic_vector(3 downto 0);
			 HEX : out std_logic_vector(6 downto 0));
	end component;

	signal A   : std_logic_vector(3 downto 0);
	signal B   : std_logic_vector(3 downto 0);
	signal Cin : std_logic;
	signal Sum : std_logic_vector(4 downto 0);
	signal St  : std_logic_vector(3 downto 0);
	signal S0  : std_logic_vector(4 downto 0);
	signal S1  : std_logic_vector(3 downto 0);

	
	
begin
	process(A, B, Cin)
	begin
		A <= SW(7 downto 4);
		B <= SW(3 downto 0);
		Cin <= SW(8);
		
		Sum <= ('0' & A) + ('0' & B) + Cin;
		if Sum > "01001" then
			S0 <= Sum - "01010"; 
			S1 <= "0001";
		else
			S0 <= Sum(4 downto 0);
			S1 <= "0000";
		end if;
	end process;

	H0: decoder7seg port map
		(BCD => S0(3 downto 0),
		 HEX => HEX0);	
		 
	H1: decoder7seg port map
		(BCD => S1,
		 HEX => HEX1);	
	
	H3: decoder7seg port map
		(BCD => B,
		 HEX => HEX3);	
		 
	H5: decoder7seg port map
		(BCD => A,
		 HEX => HEX5);

end behavioural;