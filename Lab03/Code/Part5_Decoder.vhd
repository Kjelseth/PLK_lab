library ieee;
use ieee.std_logic_1164.all;

entity decoder7seg is
	port(N   : in  std_logic_vector(3 downto 0);
         HEX : out std_logic_vector(6 downto 0));
end decoder7seg;

architecture behavioural of decoder7seg is

begin
    process(N)
	begin
        case N is
            when "0000" =>
                HEX <= "1000000";
            when "0001" =>
                HEX <= "1111001";
            when "0010" =>
                HEX <= "0100100";
            when "0011" =>
                HEX <= "0110000";
            when "0100" =>
                HEX <= "0011001";
            when "0101" =>
                HEX <= "0010010";
            when "0110" =>
                HEX <= "0000011";
            when "0111" =>
                HEX <= "1111000";
            when "1000" =>
                HEX <= "0000000";
            when "1001" =>
                HEX <= "0011000";
            when "1010" =>
                HEX <= "0001000";
            when "1011" =>
                HEX <= "0000011";
            when "1100" =>
                HEX <= "1000110";
            when "1101" =>
                HEX <= "0100001";
            when "1110" =>
                HEX <= "0000110";
            when "1111" =>
                HEX <= "0001110";
        end case;
    end process;
end behavioural;