library ieee;
use ieee.std_logic_1164.all;

entity L05P03 is
    port(CLOCK_50   : in  std_logic;
         SW         : in  std_logic_vector(2 downto 0);
         KEY        : in  std_logic_vector(3 downto 0);
         LEDR       : out std_logic_vector(9 downto 0));
end L05P03;


architecture behavioural of L05P03 is

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

    component sel_letter
        port(Selection : in  std_logic_vector(2 downto 0);
             Enable    : in  std_logic;
             Letter    : out integer);
    end component;

    signal Clk_500ms, Clk_1500ms  : std_logic := '0';
    signal Rst, disabled, startup, letter_sel : std_logic := '1';
    signal unused_num1 : std_logic_vector(24 downto 0) := (others => '0');
    signal unused_num2 : std_logic_vector(1  downto 0) := (others => '0');
    signal letter : integer;

begin
    process(CLOCK_50, startup)
    begin
        if rising_edge(CLOCK_50) and startup = '1' then
            startup <= '0';
        end if;
    end process;

    Rst <= KEY(2) and not(startup);
    Letter_sel <= KEY(3) and ...
    LEDR(9 downto 1) <= (others => '0');
    LEDR(0) <= ...

    K25million_divider: modulo_k_counter
        generic map
            (n => 25,
             k => 25000000)
        port map
            (Clk => CLOCK_50,
             Set => disabled,
             Svl => unused_num1,
             Rst => Rst,
             Hop => Clk_500ms,
             Num => unused_num1);
             
    K3_divider: modulo_k_counter
        generic map
            (n => 2,
             k => 3)
        port map
            (Clk => Clk_500ms,
             Set => disabled,
             Svl => unused_num2,
             Rst => Rst,
             Hop => Clk_1500ms,
             Num => unused_num2);
    
    Selector: sel_letter
        port map
            (Selection => SW(2 downto 0),
             Enable    => Letter_sel,
             Letter    => letter);

end behavioural;