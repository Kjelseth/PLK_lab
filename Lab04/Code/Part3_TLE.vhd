library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity L04P03 is
    port(CLOCK_50 : in  std_logic;
         SW       : in  std_logic_vector(1 downto 0);
         HEX0     : out std_logic_vector(6 downto 0));
end L04P03;


architecture behavioural of L04P03 is

    component decoder7seg
        port(N   : in  std_logic_vector(3 downto 0);
             HEX : out std_logic_vector(6 downto 0));
    end component;

    signal Q_fast : std_logic_vector(25 downto 0) := (others => '0');
    signal Q_slow : std_logic_vector(3 downto 0) := (others => '0');

begin
    process(SW, Q_fast, Q_slow, CLOCK_50)
    begin
        if (rising_edge(CLOCK_50) and SW(1) = '1') then
            if Q_fast = "10111110101111000010000000" then
                Q_fast <= (others => '0');
                Q_slow <= Q_slow + 1;
            else
            Q_fast <= Q_fast + 1;
            end if;
        end if;
        if (rising_edge(CLOCK_50) and Q_slow = "1010") then
            Q_slow <= (others => '0');
        end if;
        if (rising_edge(CLOCK_50) and SW(0) = '0') then
            Q_fast <= (others => '0');
            Q_slow <= (others => '0');
        end if;

    end process;
    
    D0: decoder7seg port map(
        N  => Q_slow,
        HEX => HEX0);
end behavioural;