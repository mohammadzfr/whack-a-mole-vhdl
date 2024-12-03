library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ScoreCounter is
    Port (
        clk       : in std_logic;
        reset     : in std_logic;
        hit       : in std_logic; -- Player hit signal
        score_out : out std_logic_vector(7 downto 0) -- Score (BCD)
    );
end ScoreCounter;

architecture Behavioral of ScoreCounter is
    signal score : integer := 0;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            score <= 0;
        elsif rising_edge(clk) and hit = '1' then
            score <= score + 1;
        end if;
        score_out <= std_logic_vector(to_unsigned(score, 8));
    end process;
end Behavioral;

