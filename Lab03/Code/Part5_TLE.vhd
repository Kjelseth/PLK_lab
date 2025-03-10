library ieee;
use ieee.std_logic_1164.all;

entity L03P05 is
    port(SW         : in  std_logic_vector(7 downto 0);
         KEY        : in  std_logic_vector(1 downto 0);
         LEDR       : out std_logic_vector(9 downto 0);
         HEX0, HEX1 : out std_logic_vector(9 downto 0);
         HEX2, HEX3 : out std_logic_vector(9 downto 0);
         HEX4, HEX5 : out std_logic_vector(9 downto 0));
end L03P05;


architecture behavioural of L03P05 is

    component display
        port(Num  : in  std_logic_vector(7 downto 0);
             HEXa : out std_logic_vector(6 downto 0);
             HEXB : out std_logic_vector(6 downto 0));
    end component;

    component Reg
        port(Clk : in  std_logic;
             Rst : in  std_logic;
             D   : in  std_logic_vector(7 downto 0);
             Q   : out std_logic_vector(7 downto 0));
    end component;

    signal A, B : std_logic_vector(7 downto 0);
    signal S    : std_logic_vector(8 downto 0);
    signal swap : std_logic;

begin

    LEDR(9 downto 1) <= "000000000";
    
    process(SW, KEY, A, B, S)
    begin
        S = A + B;
        LEDR(0)          <= S(8);
        if rising_edge(KEY) then
            swap <= not(swap)
        end if;
        if swap = '0' then
            A <= SW;
        else
            B <= SW;
        end if ;
    end process;

    R0: Reg port map(
        Clk => ,
        Rst => KEY(0),
        D   => ,
        Q   => A);

    R1: Reg port map(
        Clk => ,
        Rst => KEY(0),
        D   => ,
        Q   => B);

    H0: display port map(
        Num  => B,
        HEXa => HEX0,
        HEXb => HEX1);

    H1: display port map(
        Num  => A,
        HEXa => HEX2,
        HEXb => HEX3);  
        
    H2: display port map(
        Num  => S(7 downto 0),
        HEXa => HEX4,
        HEXb => HEX5);

end behavioural;