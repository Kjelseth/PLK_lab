library ieee;
use ieee.std_logic_1164.all;

entity L03P02_1 is
    port(Clk, D : in  std_logic;
         Q      : out std_logic);
end L03P02_1;

architecture structural of L03P02_1 is
    signal R, S, R_g, S_g, Qa, Qb : std_logic;
    attribute keep : boolean;
    attribute keep of R, S, R_g, S_g, Qa, Qb : signal is true;
begin
    R   <= not(D);
    S   <= D;
    R_g <= not(R and Clk);
    S_g <= not(S and Clk);
    Qa  <= not(R_g and Qb);
    Qb  <= not(S_g and Qa);
    Q   <= Qa;
end structural;