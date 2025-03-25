library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_BCD is
    port(Num    : in  std_logic_vector(6 downto 0);
         HEXlsd : out std_logic_vector(6 downto 0);
         HEXmsd : out std_logic_vector(6 downto 0));
end display_BCD;

architecture behavioural of display_BCD is

    component decoder7seg
        port(N   : in  std_logic_vector(3 downto 0);
             HEX : out std_logic_vector(6 downto 0));
    end component;

    signal lsd, msd : std_logic_vector(3 donwto 0);
    signal Num_int, lsd_int, msb_int : integer;


begin
    process(Num)
        Num_int <= to_integer(unsigned(Num));

        if (Num_int >= 0 and Num_int < 10) then
            msd <= "0000";
        elsif (Num_int >= 10 and Num_int < 20) then
            msd <= "0001";
        elsif (Num_int >= 20 and Num_int < 30) then
            msd <= "0010";
        elsif (Num_int >= 30 and Num_int < 40) then
            msd <= "0011";
        elsif (Num_int >= 40 and Num_int < 50) then
            msd <= "0100";
        elsif (Num_int >= 50 and Num_int < 60) then
            msd <= "0101";
        elsif (Num_int >= 60 and Num_int < 70) then
            msd <= "0110";
        elsif (Num_int >= 70 and Num_int < 80) then
            msd <= "0111";
        elsif (Num_int >= 80 and Num_int < 90) then
            msd <= "1000";
        elsif (Num_int >= 90 and Num_int < 100) then
            msd <= "1001";
        end if;
        
        msb_int <= to_integer(unsigned(msd));
        lsd_int <= Num_int - msb_int;
        lsd <= std_logic_vector(to_unsigned(lsd_int, lsd'lenght));
    end process;

    HEX_lsd: decoder7seg port map
            (N   => lsd,
             HEX => HEXlsd);

    HEX_msd: decoder7seg port map
            (N   => msd,
             HEX => HEXmsd);

end behavioural;