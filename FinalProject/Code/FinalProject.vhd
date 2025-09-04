library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FinalProject is
    port(CLOCK_50 : in  std_logic;
         SW       : in  std_logic_vector(3 downto 0);
         KEY      : in  std_logic_vector(1 downto 0);
         LEDR     : out std_logic_vector(9 downto 0);
         HEX0     : out std_logic_vector(6 downto 0));
end entity;


architecture behavioural of FinalProject is

    signal startup                      : std_logic := '1';
    signal Reset, Load, Shift, Display  : std_logic;
    signal Symbol, LetterSize, SizeLoad : integer range 0 to 15;
    signal Letter, LetterLoad           : std_logic_vector(13 downto 0);
    -- All signals except startup is to connect modules
begin
    
    LEDR(9 downto 4) <= (others => '0');
    LEDR(1 downto 0) <= (others => '0');
    LEDR(2)          <= not KEY(0);

    process(CLOCK_50) is -- Self reseting on startup
    begin
        if rising_edge(CLOCK_50) and startup = '1' then
            startup <= '0';
        end if;
    end process;

    Reset <= KEY(0) and not(startup);
    
    -- Transforms switch selection to data
    Selector: entity work.LetterSelection(behavioural)
        port map(Clk          => CLOCK_50,
                 nRst         => Reset,
                 Selection    => SW(3 downto 0),
                 Symbol       => Symbol,
                 LetterData   => LetterLoad,
                 LetterSize   => SizeLoad);
    
    -- Saves selection and shifts data
    ShiftRegister: entity work.LetterRegister(behavioural)
        port map(nRst         => Reset,
                 Shift        => Shift,
                 Load         => Load,
                 LetterLoad   => LetterLoad,
                 SizeLoad     => SizeLoad,
                 LetterOut    => Letter,
                 SizeOut      => LetterSize);
    
    -- Decoder for the 7 segment display output
    DisplayDecoder: entity work.Decoder7Segment(behavioural)
        port map(nRst         => Reset,
                 Enable       => Display,
                 Load         => Load,
                 Symbol       => Symbol,
                 HEX          => HEX0);
    
    -- Controlls the logic with states and controlls register and output
    LogicUnit: entity work.GammaLogic(behavioural)
        port map(Clk          => CLOCK_50,
                 nRst         => Reset,
                 nEnable      => KEY(1),
                 Shift        => Shift,
                 Load         => Load,
                 Letter       => Letter,
                 LetterSize   => LetterSize,
                 LEDoutput    => LEDR(3),
                 Display      => Display);

end architecture;