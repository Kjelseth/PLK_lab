library ieee;
use ieee.std_logic_1164.all;

entity LetterShiftRegister is
    port(Clk       : in  std_logic;
         nRst      : in  std_logic;
         Enable    : in  std_logic;
         Load      : in  std_logic;
         LetterNew : in  std_logic_vector(3 downto 0);
         LetterOut : out std_logic_vector(3 downto 0));
end entity;


architecture behavioural of LetterShiftRegister is

    signal Letter : std_logic_vector(3 downto 0) := (others => '0');

begin

    LetterOut <= Letter;

    process(Clk, nRst) is
    begin
        if rising_edge(Clk) then
            if Load = '1' then
                Letter <= LetterNew;
            else
                if Enable = '1' then
                    Letter <= Letter (2 downto 0) & '-';
                end if;
            end if;
        end if;
        if nRst = '0' then
            Letter <= (others => '0');
        end if;
    end process;

end architecture;