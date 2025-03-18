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

    component Tflipflop
        port(T   : in  std_logic;
             Clk : in  std_logic;
             Rst : in  std_logic;
             Q_a : out std_logic;
             Q_b : out std_logic);
    end component;

    signal T : std_logic_vector(6 downto 0);
    Signal Q : std_logic_vector(7 downto 0);

begin
              
    T(0) <= Q(0) and E;
    T(1) <= Q(1) and T(0);
    T(2) <= Q(2) and T(1);         
    T(3) <= Q(3) and T(2);
    T(4) <= Q(4) and T(3); 
    T(5) <= Q(5) and T(4);
    T(6) <= Q(6) and T(5);

    Q_a <= Q;

    T0: Tflipflop port map(
        T   => E,
        Clk => Clk,
        Rst => Rst,
        Q_a => Q(0),
        Q_b => Q_b(0));

    T1: Tflipflop port map(
        T   => T(0),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q(1),
        Q_b => Q_b(1));

    T2: Tflipflop port map(
        T   => T(1),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q(2),
        Q_b => Q_b(2));      
    
    T3: Tflipflop port map(
        T   => T(2),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q(3),
        Q_b => Q_b(3));

    T4: Tflipflop port map(
        T   => T(3),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q(4),
        Q_b => Q_b(4));

    T5: Tflipflop port map(
        T   => T(4),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q(5),
        Q_b => Q_b(5));

    T6: Tflipflop port map(
        T   => T(5),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q(6),
        Q_b => Q_b(6));

    T7: Tflipflop port map(
        T   => T(6),
        Clk => Clk,
        Rst => Rst,
        Q_a => Q(7),
        Q_b => Q_b(7));

end structural;