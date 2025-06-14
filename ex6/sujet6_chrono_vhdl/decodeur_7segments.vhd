library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodeur_7segments is
    Port (
        BIN : in std_logic_vector(3 downto 0);
        SEG : out std_logic_vector(7 downto 0)
    );
end decodeur_7segments;

architecture Behavioral of decodeur_7segments is
begin
    process(BIN)
    begin
        case BIN is
            when "0000" => SEG <= "00100100"; -- 0
            when "0001" => SEG <= "11110101"; -- 1
            when "0010" => SEG <= "01001100"; -- 2
            when "0011" => SEG <= "11000100"; -- 3
            when "0100" => SEG <= "10010101"; -- 4
            when "0101" => SEG <= "10000110"; -- 5
            when "0110" => SEG <= "00000110"; -- 6
            when "0111" => SEG <= "10110100"; -- 7
            when "1000" => SEG <= "00000100"; -- 8
            when "1001" => SEG <= "10000100"; -- 9
            when others => SEG <= "11111111"; -- Éteint
        end case;
    end process;
end Behavioral;