library ieee;
use ieee.std_logic_1164.all;

entity LetterSize is
    port(Letter     : in  integer;
         LoadNew    : in  std_logic;
         Enable     : in  std_logic;
         Reset      : in  std_logic;
         LettSize : out integer);
end entity;


architecture behavioural of LetterSize is

    signal Size : integer := 0;
begin


    process(Enable, Rst)
    begin
        if rising_edge(Enable) and LoadNew = '0' then
            Size := Size - 1;
        elsif rising_edge(Enable) and LoadNew = '1' then
            case Letter is
                when 0 =>      -- A ._
                    Size := 2;
                when 1 =>      -- B _...
                    Size := 4;
                when 2 =>      -- C _._.
                    Size := 4;
                when 3 =>      -- D _..
                    Size := 3;
                when 4 =>      -- E .
                    Size := 1;
                when 5 =>      -- F .._.
                    Size := 4;
                when 6 =>      -- G __.
                    Size := 3;
                when 7 =>      -- H ....
                    Size := 4;
            end case;
        end if;
        if Rst = '0' then
            Size := 0;
        end if;
        LettSize := Size;
    end process;

end architecture;