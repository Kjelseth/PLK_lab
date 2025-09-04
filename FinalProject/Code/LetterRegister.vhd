library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LetterRegister is
    port(nRst       : in  std_logic;
         Shift      : in  std_logic;
         Load       : in  std_logic;
         LetterLoad : in  std_logic_vector(13 downto 0);
         SizeLoad   : in  integer range 0 to 15;
         LetterOut  : out std_logic_vector(13 downto 0);
         SizeOut    : out integer range 0 to 15);
end entity;


architecture behavioural of LetterRegister is

    signal Letter : std_logic_vector(13 downto 0) := (others => '0');
    signal Size   : integer range 0 to 15 := 0;

begin

    LetterOut <= Letter; -- Avoids reading the output while shifting
    SizeOut   <= Size;   -- Avoids reading the output while decreasing

    process(Shift, Load, LetterLoad, nRst) is
    begin -- LetterLoad in sensitivity list to update value while idle
        if rising_edge(Shift) then -- Shift acts as a clk signal
            Letter <= Letter (11 downto 0) & "--";
            Size   <= Size - 1; 
        end if;
        if Load = '1' then -- Always updates on input change
            Letter <= LetterLoad;
            Size   <= SizeLoad;
        end if;
        if nRst = '0' then -- Asynchronous reset for outputs
            Letter <= (others => '0');
            Size   <= 0;
        end if;
    end process;

end architecture;