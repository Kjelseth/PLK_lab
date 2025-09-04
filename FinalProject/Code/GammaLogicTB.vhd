library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GammaLogicTB is
end entity;


architecture behavioural of GammaLogicTB is
    
    signal Clock      : std_logic := '0';
    signal Reset      : std_logic := '0';
    signal Enable     : std_logic := '1';
    signal Shift      : std_logic;
    signal Load       : std_logic;
    signal Letter     : std_logic_vector(13 downto 0) := (others => '0');
    signal LetterSize : integer range 0 to 15 := 0;
    signal LED        : std_logic;
    signal Display    : std_logic;

    signal Done   : std_logic;

    constant HalfPeriod : time := 10 ns;

begin
    
    Clock <= not Clock after HalfPeriod when Done /= '1' else '0';

    process
    begin
        Done <= '0';
        wait for 20 ns;
        Reset <= '1';
        wait for 20 ns;
        Letter <= "0100100011----";
        LetterSize <= 5;
        wait for 20 ns;
        Enable <= '0';
        wait for 250 ns;
        Enable <= '1';
        Letter <= "00100011------";
        LetterSize <= 4;
        wait for 200 ns;
        Letter <= "100011--------";
        LetterSize <= 3;
        wait for 100 ns;
        Letter <= "0011----------";
        LetterSize <= 2;
        wait for 200 ns;
        Letter <= "11------------";
        LetterSize <= 1;
        wait for 250 ns;
        Letter <= "--------------";
        LetterSize <= 0;
        wait for 150 ns;
        Reset <= '0';
        wait for 100 ns;
        Done <= '1';
        wait;
    end process;

    LogicUnit: entity work.GammaLogicFast(behavioural)
        port map(Clk          => Clock,
                 nRst         => Reset,
                 nEnable      => Enable,
                 Shift        => Shift,
                 Load         => Load,
                 Letter       => Letter,
                 LetterSize   => LetterSize,
                 LEDoutput    => LED,
                 Display      => Display);

end architecture;