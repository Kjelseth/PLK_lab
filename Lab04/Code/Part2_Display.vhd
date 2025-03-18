library ieee;
use ieee.std_logic_1164.all;

entity display is
	port(Num  : in  std_logic_vector(7 downto 0);
         HEXa : out std_logic_vector(6 downto 0);
         HEXb : out std_logic_vector(6 downto 0);
         HEXc : out std_logic_vector(6 downto 0);
         HEXd : out std_logic_vector(6 downto 0));
end display;

architecture behavioural of display is

    component decoder7seg
        port(N   : in  std_logic_vector(3 downto 0);
             HEX : out std_logic_vector(6 downto 0));
    end component;

begin
    
    H0: decoder7seg port map(
        N => Num(3 downto 0),
        HEX => HEXa);    

    H1: decoder7seg port map(
        N => Num(7 downto 4),
        HEX => HEXb);

    H2: decoder7seg port map(
        N => Num(11 downto 8),
        HEX => HEXc);

    H3: decoder7seg port map(
        N => Num(15 downto 12),
        HEX => HEXd);

end behavioural;