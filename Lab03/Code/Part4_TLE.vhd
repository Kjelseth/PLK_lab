library ieee;
use ieee.std_logic_1164.all;

entity L03P04 is
    port(SW   : in  std_logic_vector(1 downto 0);
         KEY  : in  std_logic_vector(3 downto 0);
         LEDR : out std_logic_vector(9 downto 0));
end L03P04;


architecture structural of L03P04 is

    component Dl
        port(Clk, D : in  std_logic;
             Q      : out std_logic);
    end component;

    component Dff
        port(Clk, D : in  std_logic;
             Q      : out std_logic);
    end component;

begin

    LEDR(9 downto 3) <= "0000000";

    D0: Dl port map(
        Clk => KEY(3),
        D   => SW(0),
        Q   => LEDR(0));

    D1: Dff port map(
        Clk => KEY(3),
        D   => SW(0),
        Q   => LEDR(1));

    D2: Dff port map(
        Clk => not(KEY(3)),
        D   => SW(0),
        Q   => LEDR(2));

end structural;