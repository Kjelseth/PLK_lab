library ieee;
use ieee.std_logic_1164.all;

entity L05P02 is
    generic();
    port(SW         : in  std_logic_vector(7 downto 0);
         KEY        : in  std_logic_vector(3 downto 0);
         LEDR       : out std_logic_vector(9 downto 0);
         HEX0, HEX1 : out std_logic_vector(6 downto 0);
         HEX2, HEX3 : out std_logic_vector(9 downto 0);
         HEX4, HEX5 : out std_logic_vector(9 downto 0));
end L05P02;


architecture behavioural of L05P02 is

    component modulo_k_counter
        generic(n : natural := 4;
                k : integer := 10);
        port(Clk : in  std_logic;
             Rst : in  std_logic;
             Hop : out std_logic;
             Num : out std_logic_vector(n-1 downto 0));
    end component;

    component display_BCD
        port(Num    : in  std_logic_vector(6 downto 0);
             HEXlsd : out std_logic_vector(6 downto 0);
             HEXmsd : out std_logic_vector(6 downto 0));
    end component;

    signal Clk, Clk_h, Clk_s, Clk_m, Clk_unused : std_logic;
    signal Rst : std_logic := '1';
    signal unused_num : std_logic_vector(18 downto 0) := (others => '0');
    signal hundredths : std_logic_vector(6  downto 0) := (others => '0');
    signal seconds    : std_logic_vector(6  downto 0) := (others => '0');
    signal minutes    : std_logic_vector(6  downto 0) := (others => '0');

begin

    Clk <= CLOCK_50 and KEY(2);
    Rst <= KEY(1);

    K500000_divider: modulo_k_counter
        generic map
            (n => 19,
             k => 500000)
        port map
            (Clk => Clk,
             Rst => Rst,
             Hop => Clk_h,
             Num => unused);

    K100_hundredths: modulo_k_counter
        generic map
            (n => 7,
             k => 100)
        port map
            (Clk => Clk_h,
             Rst => Rst,
             Hop => Clk_s,
             Num => hundredths);

    K60_seconds: modulo_k_counter
        generic map
            (n => 7,
             k => 60)
        port map
            (Clk => Clk_s,
             Rst => Rst,
             Hop => Clk_m,
             Num => seconds);

    K60_minutes: modulo_k_counter
        generic map
            (n => 7,
             k => 60)
        port map
            (Clk => Clk_m,
             Rst => Rst,
             Hop => Clk_unused,
             Num => minutes);

    D_hundredths: display_BCD
        port map
            (Num    => hundredths,
             HEXlsd => HEX0
             HEXmsd => HEX1);

    D_seconds: display_BCD
        port map
            (Num    => seconds,
             HEXlsd => HEX2
             HEXmsd => HEX3);

    D_minutes: display_BCD
        port map
            (Num    => minutes,
             HEXlsd => HEX0
             HEXmsd => HEX1);

end behavioural;