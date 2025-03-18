library ieee;
use ieee.std_logic_1164.all;

entity L04P01 is
    port(SW   : in  std_logic_vector(1 downto 0);
         KEY  : in  std_logic_vector(3 downto 0);
         HEX0 : out std_logic_vector(6 downto 0);
         HEX1 : out std_logic_vector(6 downto 0));
end L04P01;


architecture structural of L04P01 is

    component counter
        port(E   : in  std_logic;
             Clk : in  std_logic;
             Rst : in  std_logic;
             Q_a : out std_logic_vector(7 downto 0);
             Q_b : out std_logic_vector(7 downto 0));
    end component;

    component display
        port(Num  : in  std_logic_vector(7 downto 0);
             HEXa : out std_logic_vector(6 downto 0);
             HEXb : out std_logic_vector(6 downto 0));
    end component;

    signal N_a : std_logic_vector(7 downto 0);
    signal N_b : std_logic_vector(7 downto 0);

begin

    C0: counter port map(
        E   => SW(1),
        Clk => KEY(3),
        Rst => SW(0),
        Q_a => N_a,
        Q_b => N_b);
    
    D0: display port map(
        Num  => N_a,
        HEXa => HEX0,
        HEXb => HEX1);

end structural;