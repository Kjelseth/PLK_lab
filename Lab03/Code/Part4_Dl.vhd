library ieee;
use ieee.std_logic_1164.all;

entity Dl is
    port(Clk, D : in  std_logic;
         Q      : out std_logic);
end Dl;

architecture behavioural of Dl is
begin
    process(Clk, D)
    begin
        if Clk = '1' then
            Q <= D;
        end if;
    end process;
end behavioural;