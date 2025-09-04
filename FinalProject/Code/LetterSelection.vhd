library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LetterSelection is
    port(Clk        : in std_logic;
         nRst       : in std_logic;
         Selection  : in std_logic_vector(3 downto 0);
         Symbol     : out integer range 0 to 15;
         LetterData : out std_logic_vector(13 downto 0);
         LetterSize : out integer range 0 to 15);
end entity;


architecture behavioural of LetterSelection is

    signal SymbolNr : integer range 0 to 15 := 0;

begin

    Symbol <= SymbolNr; -- Avoids reading the output in the case when

    process(Clk, nRst)
    begin
        if rising_edge(Clk) then
            SymbolNr <= to_integer(unsigned(Selection));
            case SymbolNr is   -- Data and size of letters stored here
                when 1 =>      -- P as - - .
                    LetterData <= "1000100001----"; -- 00 between symbols
                    LetterSize <= 5;                -- 01 for dots
                when 2 =>      -- B as | . .        -- 10 for dash
                    LetterData <= "1100010001----"; -- 11 for vertical bar
                    LetterSize <= 5;                -- -- for don't care
                when 3 =>      -- 1 as | . -
                    LetterData <= "1100010010----";
                    LetterSize <= 5;
                when 4 =>      -- 8 as . | .
                    LetterData <= "0100110001----";
                    LetterSize <= 5;
                when 5 =>      -- 0 as - . -
                    LetterData <= "1000010010----";
                    LetterSize <= 5;
                when 6 =>      -- - as -
                    LetterData <= "10------------";
                    LetterSize <= 1;
                when 7 =>      -- F as | - .
                    LetterData <= "1100100001----";
                    LetterSize <= 5;
                when 8 =>      -- G as | . . |
                    LetterData <= "11000100010011";
                    LetterSize <= 7;
                when 9 =>      -- A as . - .
                    LetterData <= "0100100001----";
                    LetterSize <= 5;
            when others =>     -- Whenever the input is something else
                    LetterData <= (others => '-');
                    LetterSize <= 0;
            end case;
        end if;

        if nRst = '0' then -- Asynchronous reset for outputs
            SymbolNr <= 0;
            LetterData <= (others => '-');
            LetterSize <= 0;
        end if;
    end process;
end architecture;