library ieee;
use ieee.std_logic_1164.all;

entity Reg is
    port(Clk : in  std_logic;
         Rst : in  std_logic;
         D   : in  std_logic_vector(7 downto 0);
         Q   : out std_logic_vector(7 downto 0));
end Reg;

architecture behavioural of Reg is
begin
    process(Clk, D)
    begin
        if falling_edge(Clk) then
            Q <= D;
        end if;
        if Rst = '0' then
            Q <= "00000000";
        end if;
    end process;
end behavioural;