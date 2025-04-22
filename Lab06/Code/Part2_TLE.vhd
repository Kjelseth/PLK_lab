library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity L06P02 is
    port(SW   : in  std_logic_vector(1 downto 0);
         KEY  : in  std_logic_vector(3 downto 0);
         LEDR : out std_logic_vector(9 downto 0));
end entity;


architecture behavioural of L06P02 is

    type TaskState is (A, B, C, D, E, F, G, H, I);
    attribute syn_encoding : string;
    attribute syn_encoding of TaskState : type is "sequential";
    signal State           : TaskState;

    signal w, z            : std_logic;
    signal ShowEncoding    : std_logic_vector(3 downto 0);

begin

    w                <= SW(1);
    LEDR(9)          <= z;
    LEDR(8 downto 4) <= (others => '0');
    LEDR(3 downto 0) <= ShowEncoding;

    process(KEY(3)) is

        procedure ChangeState(wantedValue : std_logic;
                              toState     : TaskState; 
                              elseState   : TaskState) is
        begin
            if w = wantedValue then
                State <= toState;
            else
                State <= elseState;
            end if;
        end procedure;

    begin
        if rising_edge(KEY(3)) then
            if SW(0) = '0' then
                State <= A;   -- Reset
            else
                case State is -- Next state logic

                    when A =>
                        ChangeState(wantedValue => '0',
                                    toState     => B,
                                    elseState   => F);

                    when B =>
                        ChangeState(wantedValue => '0',
                                    toState     => C,
                                    elseState   => F);

                    when C =>
                        ChangeState(wantedValue => '0',
                                    toState     => D,
                                    elseState   => F);

                    when D =>
                        ChangeState(wantedValue => '0',
                                    toState     => E,
                                    elseState   => F);

                    when E =>
                        ChangeState(wantedValue => '0',
                                    toState     => E,
                                    elseState   => F);

                    when F =>
                        ChangeState(wantedValue => '1',
                                    toState     => G,
                                    elseState   => B);

                    when G =>
                        ChangeState(wantedValue => '1',
                                    toState     => H,
                                    elseState   => B);

                    when H =>
                        ChangeState(wantedValue => '1',
                                    toState     => I,
                                    elseState   => B);

                    when I =>
                        ChangeState(wantedValue => '1',
                                    toState     => I,
                                    elseState   => B);

                end case;
            end if;
        end if;
    end process;

    process(State)
    begin
        case State is -- Output logic
            when E      => z <= '1';
            when I      => z <= '1';
            when others => z <= '0';
        end case;
    end process;

    process(State) is
    begin
        case State is -- Encoding output hardcoded sequential
            when A => ShowEncoding <= "0000";
            when B => ShowEncoding <= "0001";
            when C => ShowEncoding <= "0010";
            when D => ShowEncoding <= "0011";
            when E => ShowEncoding <= "0100";
            when F => ShowEncoding <= "0101";
            when G => ShowEncoding <= "0110";
            when H => ShowEncoding <= "0111";
            when I => ShowEncoding <= "1000";
        end case;
    end process;
end architecture;