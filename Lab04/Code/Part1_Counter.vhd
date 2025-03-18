library ieee;
use ieee.std_logic_1164.all;

entity counter is
    port(E   : in  std_logic;
         Clk : in  std_logic;
         Rst : in  std_logic;
         Q_a : out std_logic_vector(7 downto 0);
         Q_b : out std_logic_vector(7 downto 0));
end counter;


architecture structural of counter is

    component Tff
        port(T   : in  std_logic;
             Clk : in  std_logic;
             Rst : in  std_logic;
             Q_a : out std_logic;
             Q_b : out std_logic);
    end component;

    signal T : std_logic_vector(6 downto 0);

begin
    
    T0: Tff port map(
        T   => E,
        Clk => Clk,
        Rst => Rst,
        Q_a => Q_a(0),
        Q_b => Q_b(0));
        
    T(0) <= Q_a(0) and E;

    T1: Tff port map(
        T   => T(0),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q_a(1),
        Q_b => Q_b(1));
    
    T(1) <= Q_a(1) and T(0);

    T2: Tff port map(
        T   => T(1),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q_a(2),
        Q_b => Q_b(2));

    T(2) <= Q_a(2) and T(1);      
    
    T3: Tff port map(
        T   => T(2),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q_a(3),
        Q_b => Q_b(3));

    T(3) <= Q_a(3) and T(2);

    T4: Tff port map(
        T   => T(3),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q_a(4),
        Q_b => Q_b(4));
        
    T(4) <= Q_a(4) and T(3);

    T5: Tff port map(
        T   => T(4),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q_a(5),
        Q_b => Q_b(5));
    
    T(5) <= Q_a(5) and T(4);

    T6: Tff port map(
        T   => T(5),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q_a(6),
        Q_b => Q_b(6));
        
    T(6) <= Q_a(6) and T(5);

    T7: Tff port map(
        T   => T(6),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q_a(7),
        Q_b => Q_b(7));

end structural;