library ieee;
use ieee.std_logic_1164.all;

entity L01P05 is
	port(SW   : in  std_logic_vector(9 downto 0);
		 LEDR : out std_logic_vector(9 downto 0);
		 HEX0 : out std_logic_vector(6 downto 0);
		 HEX1 : out std_logic_vector(6 downto 0);
		 HEX2 : out std_logic_vector(6 downto 0);
		 HEX3 : out std_logic_vector(6 downto 0));
end L01P05;

architecture structural of L01P05 is
	
	component MUX_2bit_4to1
		port(S : in  std_logic_vector(1 downto 0);
			 U : in  std_logic_vector(1 downto 0);
			 V : in  std_logic_vector(1 downto 0);
			 W : in  std_logic_vector(1 downto 0);
			 X : in  std_logic_vector(1 downto 0);
			 M : out std_logic_vector(1 downto 0));
	end component;
	
	component DECODER_7seg
		port(C : in  std_logic_vector(1 downto 0);
			 D : out std_logic_vector(6 downto 0));
	end component;
	
	signal A   : std_logic_vector(7 downto 0);
	signal Sel : std_logic_vector(1 downto 0);
	signal IN0 : std_logic_vector(1 downto 0);
	signal IN1 : std_logic_vector(1 downto 0);
	signal IN2 : std_logic_vector(1 downto 0);
	signal IN3 : std_logic_vector(1 downto 0);

begin
	LEDR <= SW;
	
	IN0 <= SW(1 downto 0);
	IN1 <= SW(3 downto 2);
	IN2 <= SW(5 downto 4);
	IN3 <= SW(7 downto 6);
	Sel <= SW(9 downto 8);

	U0: MUX_2bit_4to1 port map
		(S => Sel,
		 U => IN0,
		 V => IN1,
		 W => IN2,
		 X => IN3,
		 M => A(1 downto 0));
		 
	U1: MUX_2bit_4to1 port map
		(S => Sel,
		 U => IN1,
		 V => IN2,
		 W => IN3,
		 X => IN0,
		 M => A(3 downto 2));
		 
	U2: MUX_2bit_4to1 port map
		(S => Sel,
		 U => IN2,
		 V => IN3,
		 W => IN0,
		 X => IN1,
		 M => A(5 downto 4));
		 
	U3: MUX_2bit_4to1 port map
		(S => Sel,
		 U => IN3,
		 V => IN0,
		 W => IN1,
		 X => IN2,
		 M => A(7 downto 6));
	
	H0: DECODER_7seg port map
		(C => A(1 downto 0),
		 D => HEX0);
		 
	H1: DECODER_7seg port map
		(C => A(3 downto 2),
		 D => HEX1);
		 
	H2: DECODER_7seg port map
		(C => A(5 downto 4),
		 D => HEX2);
		 
	H3: DECODER_7seg port map
		(C => A(7 downto 6),
		 D => HEX3);

end structural;