library ieee;
use ieee.std_logic_1164.all;

entity sel_letter is
    port(Selection : in  std_logic_vector(2 downto 0);
         Enable    : in  std_logic;
         Letter    : out integer);
end sel_letter;


architecture behavioural of sel_letter is

    signal Sel : std_logic_vector(3 downto 0);

begin
    process(Enable)
    begin
        if Enable = '1' then
            Letter <= to_unsigned(Sel);
        end if;
    end process;
end behavioural;