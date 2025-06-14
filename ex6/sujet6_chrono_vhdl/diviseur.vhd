library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity diviseur is
    Port (
        CLK      : in std_logic;
        RESET    : in std_logic;
        pulse_1s : out std_logic
    );
end diviseur;

architecture Behavioral of diviseur is
    signal count : std_logic_vector(25 downto 0) := (others => '0');
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                count <= (others => '0');
            else
                if count = 49999999 then
                    count <= (others => '0');
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    pulse_1s <= '1' when count = 49999999 else '0';
end Behavioral;