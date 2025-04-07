library ieee;
use ieee.std_logic_1164.all;

entity LetterSizeRegister is
    port(Clk        : in  std_logic;
         nRst       : in  std_logic;
         Enable     : in  std_logic;
         Load       : in  std_logic;
         LetterNew  : in  integer range 0 to 8;
         LetterSize : out integer range 0 to 4);
end entity;


architecture behavioural of LetterSizeRegister is

    signal Size : integer range 0 to 4 := 0;
begin

    LetterSize <= Size;

    process(Clk, nRst) is
    begin
        if rising_edge(Clk) then
            if Enable = '1' then
                Size <= Size - 1;
            end if;
            if Load = '1' then
                case  LetterNew is
                    when 1 =>      -- A ._
                        Size <= 2;
                    when 2 =>      -- B _...
                        Size <= 4;
                    when 3 =>      -- C _._.
                        Size <= 4;
                    when 4 =>      -- D _..
                        Size <= 3;
                    when 5 =>      -- E .
                        Size <= 1;
                    when 6 =>      -- F .._.
                        Size <= 4;
                    when 7 =>      -- G __.
                        Size <= 3;
                    when 8 =>      -- H ....
                        Size <= 4;
                    when others =>
                        Size <= 0;
                end case;
            end if;
        end if;
        if nRst = '0' then
            Size <= 0;
        end if;
    end process;

end architecture;