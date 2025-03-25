library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity modulo_k_counter is
    generic(n : natural := 4;
            k : natural := 10);
    port(Clk : in  std_logic;
         Rst : in  std_logic;
         Hop : out std_logic;
         Num : out std_logic_vector(n-1 downto 0));
end modulo_k_counter;

architecture behavioural of modulo_k_counter is

begin
    process(Clk, Rst)
    begin
        if rising_edge(Clk) then
            if Num = k-1 then
                Num <= (others => '0');
                Hop <= '1';
            else
                Num <= Num + 1;
                Hop <= '0';
            end if;
        end if;
        if rising_edge(Rst) then
            Num <= (others => '0');
            Hop <= '0';
        end if;
    end process;
end behavioural;