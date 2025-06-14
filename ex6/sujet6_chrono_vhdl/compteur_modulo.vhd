library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity compteur_modulo is
    generic (N : integer := 10);
    Port (
        CLK  : in std_logic;
        RESET: in std_logic;
        EN   : in std_logic;
        Q    : out std_logic_vector(3 downto 0);
        RCO  : out std_logic
    );
end compteur_modulo;

architecture Behavioral of compteur_modulo is
    signal count : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                count <= (others => '0');
            elsif EN = '1' then
                if count = N - 1 then
                    count <= (others => '0');
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    Q <= count;
    RCO <= '1' when (count = N - 1) and EN = '1' else '0';
end Behavioral;