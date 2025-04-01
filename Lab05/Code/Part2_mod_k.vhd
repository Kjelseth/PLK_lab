library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity modulo_k_counter is
    generic(n : natural := 4;
            k : natural := 10);
    port(Clk : in  std_logic;
         Set : in  std_logic;
         Svl : in  std_logic_vector(n-1 downto 0);
         Rst : in  std_logic;
         Hop : out std_logic;
         Num : out std_logic_vector(n-1 downto 0));
end modulo_k_counter;

architecture behavioural of modulo_k_counter is

    signal Val : std_logic_vector(n-1 downto 0) := (others => '0');

begin
    process(Clk, Rst, Set)
    begin
        if rising_edge(Clk) then
            if Val >= k-1 then
                Val <= (others => '0');
                Hop <= '1';
            else
                Val <= Val + 1;
                Hop <= '0';
            end if;
        end if;
        if Set = '0' then
            if Svl >= k then
                Val <= (others => '0');
                Hop <= '1';
            else
                Val <= Svl;
                Hop <= '0';
            end if;
        end if ;
        if Rst = '0' then
            Val <= (others => '0');
            Hop <= '0';
        end if;
        Num <= Val;
    end process;
end behavioural;