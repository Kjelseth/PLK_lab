library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MorseLogic is
    port(Clk         : in  std_logic;
         nRst        : in  std_logic;
         nEnable     : in  std_logic;
         Letter      : in  std_logic_vector(3 downto 0);
         LetterSize  : in  integer range 0 to 4;
         LoadLetter  : out std_logic;
         ShiftLetter : out std_logic;
         OutLED      : out std_logic);
end entity;


architecture behavioural of MorseLogic is

    type MorseState is (Sleep, Running, Dot, Dash, Between);
    signal State : MorseState;
    signal Count : integer range 0 to 75e6;

begin

    process(Clk, nRst) is
    begin
        if rising_edge(Clk) then
            Count <= Count + 1;
            case State is

                when Sleep =>
                OutLED <= '0';
                    if nEnable = '0' then
                        LoadLetter <= '1';
                        State <= Running;
                    end if;

                when Running =>
                    if not (LetterSize = 0) then
                        LoadLetter <= '0';
                        if Letter(3) = '0' then
                            State <= Dot;
                            ShiftLetter <= '1';
                            Count <= 0;
                        elsif Letter(3) = '1' then
                            State <= Dash;
                            ShiftLetter <= '1';
                            Count <= 0;
                        end if;
                    end if;

                when Dot =>
                    if Count = 25e6 - 1 then
                        Count <= 0;
                        if LetterSize = 0 then
                            State <= Sleep;
                        else
                            State <= Between;
                        end if;
                    else
                        OutLED <= '1';
                        ShiftLetter <= '0';
                    end if;

                when Dash =>
                    if Count = 75e6 - 1 then
                        Count <= 0;
                        if LetterSize = 0 then
                            State <= Sleep;
                        else
                            State <= Between;
                        end if;
                    else
                        OutLED <= '1';
                        ShiftLetter <= '0';
                    end if;

                when Between =>
                    OutLED <= '0';
                    if Count = 25e6 - 1 then
                        Count <= 0;
                        State <= Running;
                    end if;
            
            end case;
        end if;
        if nRst = '0' then
            State <= Sleep;
            Count <= 0;
            LoadLetter <= '0';
            ShiftLetter <= '0';
            OutLED <= '0';
        end if;
    end process;

end architecture;
