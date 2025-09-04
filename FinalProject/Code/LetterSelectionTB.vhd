library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LetterSelectionTB is
end entity;


architecture behavioural of LetterSelectionTB is

    signal Clock      : std_logic := '0';
    signal Reset      : std_logic := '0';
    signal Selection  : std_logic_vector(3 downto 0) := "0000";
    signal Symbol     : integer range 0 to 15;
    signal LetterData : std_logic_vector(13 downto 0);
    signal LetterSize : integer range 0 to 15;

    signal Done   : std_logic;

    constant HalfPeriod : time := 10 ns;

begin
    
    Clock <= not Clock after HalfPeriod when Done /= '1' else '0';

    process
    begin
        Done <= '0';
        wait for 10 ns;
        Reset <= '1';
        wait for 100 ns;
        Selection <= "1000";
        wait for 100 ns;
        Selection <= "1111";
        wait for 100 ns;
        Selection <= "0011";
        wait for 100 ns;
        Reset <= '0';
        wait for 100 ns;
        Reset <= '1';
        wait for 100 ns;
        Done <= '1';
        wait;
    end process;
    
    Selector: entity work.LetterSelection(behavioural)
        port map(Clk          => Clock,
                 nRst         => Reset,
                 Selection    => Selection,
                 Symbol       => Symbol,
                 LetterData   => LetterData,
                 LetterSize   => LetterSize);

end architecture;