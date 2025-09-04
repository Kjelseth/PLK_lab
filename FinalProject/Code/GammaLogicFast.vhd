library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GammaLogicFast is
    port(Clk        : in  std_logic;
         nRst       : in  std_logic;
         nEnable    : in  std_logic;
         Shift      : out std_logic;
         Load       : out std_logic;
         Letter     : in  std_logic_vector(13 downto 0);
         LetterSize : in  integer range 0 to 15;
         LEDoutput  : out std_logic;
         Display    : out std_logic);
end entity;


architecture behavioural of GammaLogicFast is

    type GammaState is (       -- Custom type with states of choice
        Idle, Running, DotOn, DotOff, Dash, Bar, Between);
    signal State : GammaState; -- State variable of the custom type
    signal TimeCounter : integer range 0 to 100; -- Low for simulation

begin

    process(Clk, nRst) is
    begin
        if rising_edge(Clk) then
            TimeCounter <= TimeCounter + 1; -- Time is short for simulation
            case State is    -- State change case for controlling states

                when Idle => -- Waiting for button press
                    if nEnable = '0' then
                        State <= Running;
                    end if;

                when Running => -- Routing signal on/off
                    if LetterSize = 0 then
                        State <= Idle;    -- Return to Idle when done
                    else                  -- Routes based on letter data 
                        TimeCounter <= 0; -- Restarts counter each symbol
                        if    Letter(13 downto 12) = "00" then
                            State <= Between;
                        elsif Letter(13 downto 12) = "01" then
                            State <= DotOn;
                        elsif Letter(13 downto 12) = "10" then
                            State <= Dash;
                        elsif Letter(13 downto 12) = "11" then
                            State <= Bar;
                        else -- As a safety measure return to Idle
                            State <= Idle;
                        end if;
                    end if;

                when Between => -- Waiting 8 cycles between two symbols
                    if TimeCounter >= 7 then
                        State <= Running;
                    end if;
                
                when DotOn => -- Displaying dot . for 2 cycles 4 times
                    if    TimeCounter >= 13 then
                        State <= Running;
                    elsif (TimeCounter = 1  or 
                           TimeCounter = 5  or 
                           TimeCounter = 9) then
                        State <= DotOff;
                    end if;
                
                when DotOff => -- Turning dot off for 2 cycles 3 times
                    if (TimeCounter =  3  or
                        TimeCounter =  7  or
                        TimeCounter >= 11) then
                        State <= DotOn;
                    end if;
                
                when Dash => -- Displaying dash - for 6 cycles 1 time
                    if TimeCounter >= 5 then
                        State <= Running;
                    end if;
                
                when Bar => -- Displaying bar | for 12 cycles 1 time
                    if TimeCounter >= 11 then
                        State <= Running;
                    end if;
            end case;
        end if;

        if nRst = '0' then -- Asynchronous reset for state and counter
            State <= Idle;
            TimeCounter <= 0;
        end if;
    end process;

    process(State, nRst) is
    begin
        case State is -- Output case for controlling outputs

            when Idle =>
                LEDoutput <= '0';
                Display   <= '0';
                Shift     <= '0';
                Load      <= '1';

            when Running =>
                LEDoutput <= '0';
                Display   <= '1';
                Shift     <= '0';
                Load      <= '0';

            when Between =>
                LEDoutput <= '0';
                Display   <= '1';
                Shift     <= '1';
                Load      <= '0';
            
            when DotOn =>
                LEDoutput <= '1';
                Display   <= '1';
                Shift     <= '1';
                Load      <= '0';
            
            when DotOff =>
                LEDoutput <= '0';
                Display   <= '1';
                Shift     <= '1';
                Load      <= '0';
            
            when Dash =>
                LEDoutput <= '1';
                Display   <= '1';
                Shift     <= '1';
                Load      <= '0';
            
            when Bar =>
                LEDoutput <= '1';
                Display   <= '1';
                Shift     <= '1';
                Load      <= '0';
        end case;

        if nRst = '0' then -- Asynchronous reset for outputs
            LEDoutput <= '0';
            Display   <= '0';
            Shift     <= '0';
            Load      <= '0';
        end if;
    end process;

end architecture;