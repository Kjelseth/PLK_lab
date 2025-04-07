library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LetterSelection is
    port(Clk          : in  std_logic;
         nRst         : in  std_logic;
         Selection    : in  std_logic_vector(2 downto 0);
         LetterNumber : out integer range 0 to 8;
         LetterData   : out std_logic_vector(3 downto 0));
end entity;


architecture behavioural of LetterSelection is

    signal LetterNr : integer range 0 to 8 := 0;

begin

    process(Clk, nRst)
    begin
        if rising_edge(Clk) then
            LetterNr <= to_integer(unsigned(Selection)) + 1;
            case LetterNr is
                when 1 =>      -- A ._
                    LetterData <= "01--";
                when 2 =>      -- B _...
                    LetterData <= "1000";
                when 3 =>      -- C _._.
                    LetterData <= "1010";
                when 4 =>      -- D _..
                    LetterData <= "100-";
                when 5 =>      -- E .
                    LetterData <= "0---";
                when 6 =>      -- F .._.
                    LetterData <= "0010";
                when 7 =>      -- G __.
                    LetterData <= "110-";
                when 8 =>      -- H ....
                    LetterData <= "0000";
                when others =>
                    LetterData <= (others => '-');
            end case;
        end if;
        LetterNumber <= LetterNr;
        if nRst = '0' then
            LetterNumber <= 0;
            LetterData   <= "----";
        end if;
    end process;

end architecture;