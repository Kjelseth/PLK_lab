library ieee;
use ieee.std_logic_1164.all;

entity L05P03 is
    port(CLOCK_50   : in  std_logic;
         SW         : in  std_logic_vector(2 downto 0);
         KEY        : in  std_logic_vector(3 downto 0);
         LEDR       : out std_logic_vector(9 downto 0));
end entity;


architecture behavioural of L05P03 is

    signal startup : std_logic := '1';
    signal Rst, LoadLetter, ShiftLetter : std_logic;
    signal LetterNumber : integer range 0 to 8;
    signal LetterData, Letter : std_logic_vector(3 downto 0);
    signal LetterSize : integer range 0 to 4;

begin
    
    LEDR(9 downto 1) <= (others => '0');

    process(CLOCK_50) is
    begin
        if rising_edge(CLOCK_50) and startup = '1' then
            startup <= '0';
        end if;
    end process;

    Rst <= KEY(2) and not(startup);
    
    Selector: entity work.LetterSelection(behavioural)
        port map(Clk          => CLOCK_50,
                 nRst         => Rst,
                 Selection    => SW(2 downto 0),
                 LetterNumber => LetterNumber,
                 LetterData   => LetterData);
    
    SizeRegister: entity work.LetterSizeRegister(behavioural)
        port map(Clk          => CLOCK_50,
                 nRst         => Rst,
                 Enable       => ShiftLetter,
                 Load         => LoadLetter,
                 LetterNew    => LetterNumber,
                 LetterSize   => LetterSize);
        
    ShiftRegister: entity work.LetterShiftRegister(behavioural)
        port map(Clk          => CLOCK_50,
                 nRst         => Rst,
                 Enable       => ShiftLetter,
                 Load         => LoadLetter,
                 LetterNew    => LetterData,
                 LetterOut    => Letter);
 
    LogicUnit: entity work.MorseLogic(behavioural)
        port map(Clk          => CLOCK_50,
                 nRst         => Rst,
                 nEnable      => KEY(3),
                 Letter       => Letter,
                 LetterSize   => LetterSize,
                 LoadLetter   => LoadLetter,
                 ShiftLetter  => ShiftLetter,
                 OutLED       => LEDR(0));
             
end architecture;