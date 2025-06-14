library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decodeur_an is
    Port (
        SEL : in std_logic_vector(1 downto 0);
        AN  : out std_logic_vector(3 downto 0)
    );
end decodeur_an;

architecture Behavioral of decodeur_an is
begin
    process(SEL)
    begin
        case SEL is
            when "00" => AN <= "1110";
            when "01" => AN <= "1101";
            when "10" => AN <= "1011";
            when "11" => AN <= "0111";
            when others => AN <= "1111";
        end case;
    end process;
end Behavioral;