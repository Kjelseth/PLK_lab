library ieee;
use ieee.std_logic_1164.all;

entity L06P01 is
    port(SW   : in  std_logic_vector(1 downto 0);
         KEY  : in  std_logic_vector(3 downto 0);
         LEDR : out std_logic_vector(9 downto 0));
end entity;


architecture structural of L06P01 is

    signal Vcc, w, z       : std_logic;
    signal NewState, State : std_logic_vector(8 downto 0);

begin

    Vcc              <= '1';
    w                <= SW(1);
    LEDR(9)          <= z;
    LEDR(8 downto 0) <= State;

    process(State) is
    begin
        z           <= State(4) or State(8);
        NewState(0) <= '0';
        NewState(1) <= (not w) and
                       (State(0) or State(5) or State(6) or State(7) or State(8));
        NewState(2) <= (not w) and State(1);
        NewState(3) <= (not w) and State(2);
        NewState(4) <= (not w) and (State(3) or State(4));
        NewState(5) <= w and
                       (State(0) or State(1) or State(2) or State(3) or State(4));
        NewState(6) <= w and State(5);
        NewState(7) <= w and State(6);
        NewState(8) <= w and (State(7) or State(8));
        
    end process;

    
    StateRegister: entity work.StateRegister(structural)
        port map(Clk      => KEY(3),
                 nRst     => SW(0),
                 Enable   => Vcc,
                 NewState => NewState,
                 State    => State);

end architecture;