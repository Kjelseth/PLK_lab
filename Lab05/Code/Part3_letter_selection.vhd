library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LetterSelection is
    port(Selection  : in  std_logic_vector(2 downto 0);
         Enable     : in  std_logic;
         LetterNr   : out integer;
         LetterData : out std_logic_vector(3 downto 0));
end entity;


architecture behavioural of LetterSelection is

    signal LetterNumber : integer := 0;

begin

    process(Enable)
    begin
        if rising_edge(Enable) then
            LetterNumber <= to_integer(unsigned(Selection));
            case LetterNumber is
                when 0 =>      -- A ._
                    LetterData <= "01--";
                when 1 =>      -- B _...
                    LetterData <= "1000";
                when 2 =>      -- C _._.
                    LetterData <= "1010";
                when 3 =>      -- D _..
                    LetterData <= "100-";
                when 4 =>      -- E .
                    LetterData <= "0---";
                when 5 =>      -- F .._.
                    LetterData <= "0010";
                when 6 =>      -- G __.
                    LetterData <= "110-";
                when 7 =>      -- H ....
                    LetterData <= "0000";
            end case;
        end if;
        LetterNr <= LetterNumber;
    end process;

end architecture;