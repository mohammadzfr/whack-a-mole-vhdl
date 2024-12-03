library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WhackAMole is
    Port (
        clk       : in std_logic;
        reset     : in std_logic;
        difficulty: in std_logic;
        buttons   : in std_logic_vector(3 downto 0); -- Player input
        leds      : out std_logic_vector(3 downto 0); -- Active mole LEDs
        seg       : out std_logic_vector(6 downto 0); -- 7-segment display
        an        : out std_logic_vector(3 downto 0) -- Active display select
    );
end WhackAMole;

architecture Behavioral of WhackAMole is
    signal timer_out   : std_logic_vector(7 downto 0);
    signal score_out   : std_logic_vector(7 downto 0);
    signal mole_out    : std_logic_vector(3 downto 0);
    signal hit         : std_logic;

    component GameTimer is
        Port (clk, reset : in std_logic; timer_out : out std_logic_vector(7 downto 0));
    end component;

    component ScoreCounter is
        Port (clk, reset, hit : in std_logic; score_out : out std_logic_vector(7 downto 0));
    end component;

    component MoleRandomizer is
        Port (clk, reset, difficulty : in std_logic; mole_out : out std_logic_vector(3 downto 0));
    end component;

    component SevenSegmentDecoder is
        Port (digit : in std_logic_vector(3 downto 0); seg : out std_logic_vector(6 downto 0));
    end component;
begin
    -- Timer
    U1: GameTimer port map(clk => clk, reset => reset, timer_out => timer_out);

    -- Score Counter
    U2: ScoreCounter port map(clk => clk, reset => reset, hit => hit, score_out => score_out);

    -- Mole Randomizer
    U3: MoleRandomizer port map(clk => clk, reset => reset, difficulty => difficulty, mole_out => mole_out);

    -- Player hit detection
    hit <= '1' when buttons = mole_out else '0';

    -- LEDs show active mole
    leds <= mole_out;

    -- 7-segment display for timer and score (multiplexed externally)
    -- Timer tens place
    U4: SevenSegmentDecoder port map(digit => timer_out(7 downto 4), seg => seg);
    an <= "1110"; -- Enable specific display for timer tens
end Behavioral;

