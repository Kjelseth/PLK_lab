library ieee;
use ieee.std_logic_1164.all;

entity L05P03 is
    port(CLOCK_50   : in  std_logic;
         SW         : in  std_logic_vector(2 downto 0);
         KEY        : in  std_logic_vector(3 downto 0);
         LEDR       : out std_logic_vector(9 downto 0));
end entity;


architecture behavioural of L05P03 is

    component modulo_k_counter
        generic(n : natural := 4;
                k : integer := 10);
        port(Clk : in  std_logic;
             Rst : in  std_logic;
             Hop : out std_logic);
    end component;

    component LetterSelection
        port(Selection  : in  std_logic_vector(2 downto 0);
             Enable     : in  std_logic;
             LetterNr   : out integer;
             LetterData : out std_logic_vector(3 downto 0));
    end component;

    component LetterSize
        port(Letter     : in  integer;
             LoadNew    : in  std_logic;
             Enable     : in  std_logic;
             Reset      : in  std_logic;
             LettSize : out integer);
    end component;

    component LetterShiftRegister
        port(LetterNew     : in  std_logic_vector(3 downto 0);
             LetterIn      : in  std_logic_vector(3 downto 0);
             Enable        : in  std_logic;
             LoadNew       : in  std_logic;
             LetterShifted : out std_logic_vector(3 downto 0));
    end component;

    component MorseLogic
        port(Clk         : in  std_logic;
             ClkDot      : in  std_logic;
             ClkDash     : in  std_logic;
             Enable      : in  std_logic;
             Reset       : in  std_logic;
             LettSize  : in  integer;
             FromShifter : in  std_logic_vector(3 downto 0);
             LoadNew     : out std_logic;
             ShiftEnable : out std_logic;
             ResetClk    : out std_logic;
             OutLED      : out std_logic);
    end component;

    signal Clk_500ms, Clk_1500ms  : std_logic := '0';
    signal Rst, disabled, startup : std_logic := '1';
    signal LettSize, LetterNr : integer;
    signal FromShifter, ToShifter : std_logic_vector(3 downto 0);
    signal LoadNew, ShiftEnable : std_logic;
    signal LetterData : std_logic_vector(3 downto 0);
    signal ResetClkSignal, ResetClk : std_logic;


begin
    
    LEDR(9 downto 1) <= (others => '0');

    process(CLOCK_50, startup)
    begin
        if rising_edge(CLOCK_50) and startup = '1' then
            startup <= '0';
        end if;
    end process;

    Rst <= KEY(2) and not(startup);
    ResetClk <= Rst and not(ResetClkSignal);

    

    Clock500ms: modulo_k_counter
        generic map
            (n => 25,
             k => 25000000)
        port map
            (Clk => CLOCK_50,
             Rst => ResetClk,
             Hop => Clk_500ms);
             
    Counter2bit: modulo_k_counter
        generic map
            (n => 2,
             k => 3)
        port map
            (Clk => Clk_500ms,
             Rst => ResetClk,
             Hop => Clk_1500ms);
    
    LetterSelectionLogic: LetterSelection
        port map
            (Selection  => SW(2 downto 0),
             Enable     => KEY(3),
             LetterNr   => LetterNr,
             LetterData => LetterData);
    
    LetterSizeRegister: LetterSize
        port map
            (Letter     => LetterNr,
             LoadNew    => LoadNew,
             Enable     => ShiftEnable,
             Reset      => Rst,
             LettSize => LettSize);
        
    LetterSymbolShiftRegister: LetterShiftRegister
        port map
            (LetterNew     => LetterData,
             LetterIn      => FromShifter,
             Enable        => ShiftEnable,
             LoadNew       => LoadNew,
             LetterShifted => FromShifter);
    
    LogicUnit: MorseLogic
        port map
            (Clk         => CLOCK_50,
             ClkDot      => Clk_500ms,
             ClkDash     => Clk_1500ms,
             Enable      => KEY(3),
             Reset       => Rst,
             LettSize  => LettSize,
             FromShifter => FromShifter,
             LoadNew     => LoadNew,
             ShiftEnable => ShiftEnable,
             ResetClk    => ResetClkSignal,
             OutLED      => LEDR(0));
             
end architecture;