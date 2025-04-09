library ieee;
use ieee.std_logic_1164.all;

entity StateRegister is
    port(Clk      : in  std_logic;
         nRst     : in  std_logic;
         Enable   : in  std_logic;
         NewState : in  std_logic_vector(8 downto 0);
         State    : out std_logic_vector(8 downto 0));
end entity;


architecture structural of StateRegister is
    
begin

    process(Clk) is
    begin
        if rising_edge(Clk) then
            if nRst = '0' then
                State <= "000000001"
            else
                if Enable = '1' then
                    State <= NewState;
                end if;
            end if;
        end if;
    end process;

end architecture;