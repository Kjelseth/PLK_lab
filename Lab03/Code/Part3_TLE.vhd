library ieee;
use ieee.std_logic_1164.all;

entity L03P03 is
    port(SW   : in  std_logic_vector(1 downto 0);
         LEDR : out std_logic_vector(9 downto 0));
end L03P03;


architecture structural of L03P03 is
    component Dl
        port(Clk, D : in  std_logic;
             Q      : out std_logic);
    end component;
    signal m : std_logic;
begin
    LEDR(9 downto 1) <= "000000000";
    D0: Dl port map(
        Clk => not(SW(1)),
        D   => SW(0),
        Q   => m);
    D1: Dl port map(
        Clk => SW(1),
        D   => m,
        Q   => LEDR(0));
end structural;