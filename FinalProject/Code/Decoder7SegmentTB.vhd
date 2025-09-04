library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder7SegmentTB is
end entity;


architecture behavioural of Decoder7SegmentTB is

    signal Reset    : std_logic := '0';
    signal Enable   : std_logic := '0';
    signal Load     : std_logic := '0';
    signal SymbolNr : integer range 0 to 15 := 0;
    signal HEX      : std_logic_vector(6 downto 0);

begin
    
    process
    begin
        wait for 20 ns;
        Reset <= '1';
        wait for 20 ns;
        SymbolNr <= 5;
        Load <= '1';
        wait for 20 ns;
        SymbolNr <= 3;
        wait for 20 ns;
        Load <= '0';
        Enable <= '1';
        wait for 20 ns;
        SymbolNr <= 7;
        wait for 20 ns;
        Enable <= '0';
        wait for 20 ns;
        Enable <= '1';
        wait for 20 ns;
        Load <= '1';
        wait for 20 ns;
        SymbolNr <= 10;
        wait for 20 ns;
        Reset <= '0';
        wait for 20 ns;
        wait;
    end process;

    
    -- Decoder for the 7 segment display output
    DisplayDecoder: entity work.Decoder7Segment(behavioural)
        port map(nRst         => Reset,
                 Enable       => Enable,
                 Load         => Load,
                 Symbol       => SymbolNr,
                 HEX          => HEX);

end architecture;