library ieee;
use ieee.std_logic_1164.all;

entity L05P01 is
    generic(output_size : natural := 5);
    port(KEY  : in  std_logic_vector(3 downto 0);
         LEDR : out std_logic_vector(9 downto 0));
end L05P01;


architecture structural of L05P01 is

    component modulo_k_counter
        generic(n : natural := 4;
                k : integer := 10);
        port(Clk : in  std_logic;
             Rst : in  std_logic;
             Hop : out std_logic;
             Num : out std_logic_vector(n-1 downto 0));
    end component;

    signal display  : std_logic_vector(output_size-1 downto 0);
    signal rollover : std_logic;
    signal Clk, Rst : std_logic;

begin

    LEDR(output_size-1 downto 0) <= display;
    LEDR(8 downto output_size) <= (others => '0');
    LEDR(9) <= rollover;

    Clk <= KEY(3);
    Rst <= KEY(2);

    K20: modulo_k_counter
            generic map
                (n => output_size,
                 k => 20)
            port map
                (Clk => Clk,
                 Rst => Rst,
                 Hop => rollover,
                 Num => display);

end structural;