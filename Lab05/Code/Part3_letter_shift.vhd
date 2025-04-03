library ieee;
use ieee.std_logic_1164.all;

entity LetterShiftRegister is
    port(LetterNew     : in  std_logic_vector(3 downto 0);
         LetterIn      : in  std_logic_vector(3 downto 0);
         Enable        : in  std_logic;
         LoadNew       : in  std_logic;
         LetterShifted : out std_logic_vector(3 downto 0));
end entity;


architecture behavioural of LetterShiftRegister is

begin

    process(Enable)
    begin
        if rising_edge(Enable) and LoadNew = '0' then
            LetterShifted <= LetterIn(2 downto 0) & '-';
        elsif rising_edge(Enable) and LoadNew = '1' then
            LetterShifted <= LetterNew;
        end if;
    end process;

end architecture;