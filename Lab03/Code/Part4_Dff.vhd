library ieee;
use ieee.std_logic_1164.all;

entity Dff is
    port(Clk, D : in  std_logic;
         Q      : out std_logic);
end Dff;

architecture behavioural of Dff is
begin
    process(Clk, D)
    begin
        if rising_edge(Clk) then
            Q <= D;
        end if;
    end process;
end behavioural;