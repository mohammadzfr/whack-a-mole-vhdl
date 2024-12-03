library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GameTimer is
    Port (
        clk      : in std_logic; -- System clock
        reset    : in std_logic; -- Reset signal
        timer_out : out std_logic_vector(7 downto 0) -- Time remaining in seconds (BCD)
    );
end GameTimer;

architecture Behavioral of GameTimer is
    signal count : integer := 30; -- Start with 30 seconds
begin
    process(clk, reset)
    begin
        if reset = '1' then
            count <= 30;
        elsif rising_edge(clk) then
            if count > 0 then
                count <= count - 1;
            end if;
        end if;
        timer_out <= std_logic_vector(to_unsigned(count, 8));
    end process;
end Behavioral;

