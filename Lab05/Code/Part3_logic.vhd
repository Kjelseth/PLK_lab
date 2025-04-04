library ieee;
use ieee.std_logic_1164.all;

entity MorseLogic is
    port(Clk         : in  std_logic;
         ClkDot      : in  std_logic;
         ClkDash     : in  std_logic;
         Enable      : in  std_logic;
         Reset       : in  std_logic;
         LettSize    : in  integer;
         FromShifter : in  std_logic_vector(3 downto 0);
         LoadNew     : out std_logic;
         ShiftEnable : out std_logic;
         ResetClk    : out std_logic;
         OutLED      : out std_logic);
end entity;


architecture behavioural of MorseLogic is

    signal Load    : std_logic := '0';
    signal Running : std_logic := '0';
    signal Step    : std_logic := '0';
    signal RstClk  : std_logic := '0';
    signal Dot, Dash, Between : std_logic  := '0';

begin

    process(Clk)
    begin
        if rising_edge(Clk) and Enable = '1' and Load = '0' then
            Load        <= '1';
            LoadNew     <= '1';
            ShiftEnable <= '1';
            Running     <= '1';
        elsif rising_edge(Clk) and Load = '1' then
            LoadNew     <= '0';
            ShiftEnable <= '0';
            Load        <= '0';
            Step        <= '1';
        end if;
    end process;

    process(Clk)
    begin
        if rising_edge(Clk) and Running = '1' then
            if LettSize > 0 then
                if Dot = '0' and Dash = '0' and Between = '0' then
                    RstClk <= '1';
                    if Step = '1' then
                        if FromShifter(3) = '0' then
                            Dot  <= '1';
                            Step <= '0';
                        elsif FromShifter(3) = '1' then
                            Dash <= '1';
                            Step <= '0';
                        end if;
                    elsif Step = '0' then
                        Between <= '1';
                        Step    <= '1';
                    end if;
                end if;
            elsif LettSize = 0 then
                Running <= '0';
            end if;
        end if;
    end process;
    LoadNew <= Load;

    process(Clk)
    begin
        if rising_edge(Clk) and Dot = '1' then
            OutLED      <= '1';     -- Displays dot
            ShiftEnable <= '1';
            wait until ClkDot = '1';
            OutLED      <= '0';
            ShiftEnable <= '0';
            Dot         <= '0';
        elsif rising_edge(Clk) and Dash = '1' then
            OutLED      <= '1';     -- Displays dash
            ShiftEnable <= '1';
            wait until ClkDash = '1';
            OutLED      <= '0';
            ShiftEnable <= '0';
            Dash        <= '0';
        elsif rising_edge(Clk) and Between = '1' then
            OutLED      <= '0';     -- Waits between
            wait until ClkDot = '1';
            Between     <= '0';
        end if;
    end process;

    process(Clk)
    begin
        if rising_edge(Clk) and RstClk = '1' then
            ResetClk <= '1';
            RstClk <= '0';
        elsif rising_edge(Clk) and RstClk = '0' then
            ResetClk <= '0';
        end if;
    end process;

end architecture;
