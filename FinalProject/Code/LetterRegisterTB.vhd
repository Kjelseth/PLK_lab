library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LetterRegisterTB is
end entity;


architecture behavioural of LetterRegisterTB is

    signal Reset      : std_logic := '0';
    signal Shift      : std_logic := '0';
    signal Load       : std_logic := '0';
    signal LetterLoad : std_logic_vector(13 downto 0) := (others => '0');
    signal SizeLoad   : integer range 0 to 15 := 0;
    signal LetterOut  : std_logic_vector(13 downto 0);
    signal SizeOut    : integer range 0 to 15;

begin

    process
    begin
        wait for 20 ns;
        Reset <= '1';
        wait for 20 ns;
        LetterLoad <= "11001100110011";
        SizeLoad <= 5;
        Load <= '1';
        wait for 20 ns;
        LetterLoad <= "00011011------";
        SizeLoad <= 7;
        wait for 20 ns;
        Load <= '0';
        wait for 20 ns;
        LetterLoad <= "00000000000000";
        SizeLoad <= 0;
        wait for 20 ns;
        Shift <= '1';
        wait for 20 ns;
        Shift <= '0';
        wait for 20 ns;
        Shift <= '1';
        wait for 20 ns;
        Reset <= '0';
        wait for 20 ns;
        wait;
    end process;

    ShiftRegister: entity work.LetterRegister(behavioural)
        port map(nRst         => Reset,
                 Shift        => Shift,
                 Load         => Load,
                 LetterLoad   => LetterLoad,
                 SizeLoad     => SizeLoad,
                 LetterOut    => LetterOut,
                 SizeOut      => SizeOut);

end architecture;