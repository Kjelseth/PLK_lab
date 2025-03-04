library ieee;
use ieee.std_logic_1164.all;

entity L03P02_2 is
    port(SW   : in  std_logic_vector(1 downto 0);
         LEDR : out std_logic_vector(9 downto 0));
end L03P02_2;


architecture structural of L03P02_2 is
    component Dlatch
        port(Clk, D : in  std_logic;
             Q      : out std_logic);
    end component;
begin
    LEDR(9 downto 1) <= "000000000";
    D0: Dlatch port map(
        Clk => SW(1),
        D   => SW(0),
        Q   => LEDR(0));
end structural;