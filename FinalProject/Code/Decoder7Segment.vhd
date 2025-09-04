library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder7Segment is
    port(nRst   : in  std_logic;
         Enable : in  std_logic;
         Load   : in  std_logic;
         Symbol : in  integer range 0 to 15;
         HEX    : out std_logic_vector(6 downto 0));
end entity;


architecture behavioural of Decoder7Segment is

    signal SavedSymbol : integer range 0 to 15;

begin

    process(Load, Symbol, nRst)
    begin -- Symbol in sensitivity list to continually update on input
        if Load = '1' then
            SavedSymbol <= Symbol;
        end if;

        if nRst = '0' then -- Asynchronous reset for saved symbol
            SavedSymbol <= 0;
        end if;
    end process;

    process(Enable, SavedSymbol, nRst)
    begin -- SavedSymbol in sensitivity list if it updates after Enable
        if Enable = '1' then
            case SavedSymbol is
                when 1 => -- P
                    HEX <= "0001100";
                when 2 => -- B
                    HEX <= "0000011";
                when 3 => -- 1
                    HEX <= "1111001";
                when 4 => -- 8
                    HEX <= "0000000";
                when 5 => -- 0
                    HEX <= "1000000";
                when 6 => -- -
                    HEX <= "0111111";
                when 7 => -- F
                    HEX <= "0001110";
                when 8 => -- G
                    HEX <= "1000010";
                when 9 => -- A
                    HEX <= "0001000";
                when others => -- Off for undefined symbols
                    HEX <= (others => '1');
            end case;
        else -- Off if display is not enabled
            HEX <= (others => '1');
        end if;

        if nRst = '0' then -- Asynchronous reset for outputs
            HEX <= (others => '1'); -- Display off
        end if;
    end process;

end architecture;