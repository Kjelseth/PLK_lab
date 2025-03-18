library ieee;
use ieee.std_logic_1164.all;

entity Tflipflop is
    port(T   : in  std_logic;
         Clk : in  std_logic;
         Rst : in  std_logic;
         Q_a : out std_logic;
         Q_b : out std_logic);
end Tflipflop;


architecture behavioural of Tflipflop is
    signal Q : std_logic;
begin
    process(Clk, T, Rst)
    begin
        if (rising_edge(Clk) and T = '1') then
            Q <= not Q;
        end if;
        if (rising_edge(Clk) and Rst = '0') then
            Q <= '0';
        end if;
        Q_a <= Q;
        Q_b <= not Q;
    end process;
end behavioural;