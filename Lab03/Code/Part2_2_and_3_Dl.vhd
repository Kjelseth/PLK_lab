library ieee;
use ieee.std_logic_1164.all;

entity Dl is
    port(Clk, D : in  std_logic;
         Q      : out std_logic);
end Dl;

architecture structural of Dl is
    signal R, S, R_g, S_g, Qa, Qb : std_logic;
    attribute keep : boolean;
    attribute keep of R, S, R_g, S_g, Qa, Qb : signal is true;
begin
    R   <= not(D);
    S   <= D;
    R_g <= not(R and Clk);
    S_g <= not(S and Clk);
    Qb  <= not(R_g and Qa);
    Qa  <= not(S_g and Qb);
    Q   <= Qa;
end structural;