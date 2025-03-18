library ieee;
use ieee.std_logic_1164.all;

entity Tff is
    port(T   : in  std_logic;
         Clk : in  std_logic;
         Rst : in  std_logic;
         Q_a : out std_logic;
         Q_b : out std_logic);
end Tff;


architecture behavioural of Tff is
begin
    process(Clk, T, Rst)
    begin
        if (rising_edge(Clk) and T) then
            Q_a <= not Q_a;
        end if;
        if (rising_edge(Clk) and (not Rst)) then
            Q_a <= '0';
        end if;
        Q_b <= not Q_a;
    end process;
end behavioural;