library ieee;
use ieee.std_logic_1164.all;

entity L05P02 is
    port(CLOCK_50   : in  std_logic;
         SW         : in  std_logic_vector(7 downto 0);
         KEY        : in  std_logic_vector(3 downto 0);
         LEDR       : out std_logic_vector(9 downto 0);
         HEX0, HEX1 : out std_logic_vector(6 downto 0);
         HEX2, HEX3 : out std_logic_vector(6 downto 0);
         HEX4, HEX5 : out std_logic_vector(6 downto 0));
end L05P02;


architecture behavioural of L05P02 is

    component modulo_k_counter
        generic(n : natural := 4;
                k : integer := 10);
        port(Clk : in  std_logic;
             Set : in  std_logic;
             Svl : in  std_logic_vector(n-1 downto 0);
             Rst : in  std_logic;
             Hop : out std_logic;
             Num : out std_logic_vector(n-1 downto 0));
    end component;

    component display_BCD
        port(Num    : in  std_logic_vector(6 downto 0);
             HEXlsd : out std_logic_vector(6 downto 0);
             HEXmsd : out std_logic_vector(6 downto 0));
    end component;

    signal Clk, Clk_h, Clk_s, Clk_m, overflow : std_logic := '0';
    signal Set, Rst, disabled, startup        : std_logic := '1';
    signal unused_num : std_logic_vector(18 downto 0) := (others => '0');
    signal hundredths : std_logic_vector(6  downto 0) := (others => '0');
    signal seconds    : std_logic_vector(6  downto 0) := (others => '0');
    signal minutes    : std_logic_vector(6  downto 0) := (others => '0');
    signal minutes_in : std_logic_vector(6  downto 0) := (others => '0');

begin
    process(CLOCK_50, startup)
    begin
        if rising_edge(CLOCK_50) then
            if startup = '1' then
                Rst <= '0';
                startup <= '0';
            else
                Rst <= KEY(1);
            end if;
        end if;
    end process;

    Clk <= CLOCK_50 and KEY(2);
    Set <= KEY(3);
    minutes_in <= SW(6 downto 0);
    LEDR(9 downto 1) <= (others => '0');
    LEDR(0) <= overflow;

    K500000_divider: modulo_k_counter
        generic map
            (n => 19,
             k => 500000)
        port map
            (Clk => Clk,
             Set => disabled,
             Svl => unused_num,
             Rst => Rst,
             Hop => Clk_h,
             Num => unused_num);

    K100_hundredths: modulo_k_counter
        generic map
            (n => 7,
             k => 100)
        port map
            (Clk => Clk_h,
             Set => disabled,
             Svl => hundredths,
             Rst => Rst,
             Hop => Clk_s,
             Num => hundredths);

    K60_seconds: modulo_k_counter
        generic map
            (n => 7,
             k => 60)
        port map
            (Clk => Clk_s,
             Set => disabled,
             Svl => seconds,
             Rst => Rst,
             Hop => Clk_m,
             Num => seconds);

    K60_minutes: modulo_k_counter
        generic map
            (n => 7,
             k => 60)
        port map
            (Clk => Clk_m,
             Set => Set,
             Svl => minutes_in,
             Rst => Rst,
             Hop => Overflow,
             Num => minutes);

    D_hundredths: display_BCD
        port map
            (Num    => hundredths,
             HEXlsd => HEX0,
             HEXmsd => HEX1);

    D_seconds: display_BCD
        port map
            (Num    => seconds,
             HEXlsd => HEX2,
             HEXmsd => HEX3);

    D_minutes: display_BCD
        port map
            (Num    => minutes,
             HEXlsd => HEX4,
             HEXmsd => HEX5);

end behavioural;