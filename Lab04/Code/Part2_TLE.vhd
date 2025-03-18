library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity L04P02 is
    port(SW   : in  std_logic_vector(1 downto 0);
         KEY  : in  std_logic_vector(3 downto 0);
         HEX0 : out std_logic_vector(6 downto 0);
         HEX1 : out std_logic_vector(6 downto 0);
         HEX2 : out std_logic_vector(6 downto 0);
         HEX3 : out std_logic_vector(6 downto 0));
end L04P02;


architecture behavioural of L04P02 is

    component display
        port(Num  : in  std_logic_vector(15 downto 0);
             HEXa : out std_logic_vector(6  downto 0);
             HEXb : out std_logic_vector(6  downto 0);
             HEXc : out std_logic_vector(6  downto 0);
             HEXd : out std_logic_vector(6  downto 0));
    end component;

    signal Q   : std_logic_vector(15 downto 0) := (others => '0');

begin
    process(SW, KEY, Q)
    begin
        if (rising_edge(KEY(3)) and SW(1) = '1') then
            Q <= Q + 1;
        end if;
        if (rising_edge(KEY(3)) and SW(0) = '0') then
            Q <= (others => '0');
        end if;
    end process;
    
    D0: display port map(
        Num  => Q,
        HEXa => HEX0,
        HEXb => HEX1,
        HEXc => HEX2,
        HEXd => HEX3);
end behavioural;