library ieee;
use ieee.std_logic_1164.all;

entity letter_size is
    port(Letter : in  integer;
         Enable : in  std_logic;
         Size   : out integer);
end letter_size;


architecture behavioural of letter_size is

    signal Sel : std_logic_vector(3 downto 0);

begin
    process(Enable, Letter)
    begin
        if Enable = '1' then
            case Letter is
                when 0 =>      -- A ._
                    Size <= 2;
                when 1 =>      -- B _...
                    Size <= 4;
                when 2 =>      -- C _._.
                    Size <= 4;
                when 3 =>      -- D _..
                    Size <= 3;
                when 4 =>      -- E .
                    Size <= 1;
                when 5 =>      -- F .._.
                    Size <= 4;
                when 6 =>      -- G __.
                    Size <= 3;
                when 7 =>      -- H ....
                    Size <= 4;
            end case;
        end if;
    end process;
end behavioural;