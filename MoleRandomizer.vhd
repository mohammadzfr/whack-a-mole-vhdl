library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MoleRandomizer is
    Port (
        clk        : in std_logic;
        reset      : in std_logic;
        difficulty : in std_logic; -- Easy ('0') or Hard ('1')
        mole_out   : out std_logic_vector(3 downto 0) -- Active mole (LED)
    );
end MoleRandomizer;

architecture Behavioral of MoleRandomizer is
    signal counter : integer := 0;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            mole_out <= (others => '0');
        elsif rising_edge(clk) then
            if difficulty = '0' then
                counter <= (counter + 1) mod 1000000; -- Slower for easy
            else
                counter <= (counter + 1) mod 500000; -- Faster for hard
            end if;

            -- Random mole selection
            mole_out <= std_logic_vector(to_unsigned(counter mod 4, 4));
        end if;
    end process;
end Behavioral;

