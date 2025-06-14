library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4 is
    Port (
        SEL : in std_logic_vector(1 downto 0);
        D0, D1, D2, D3 : in std_logic_vector(3 downto 0);
        Y : out std_logic_vector(3 downto 0)
    );
end mux4;

architecture Behavioral of mux4 is
begin
    process(SEL, D0, D1, D2, D3)
    begin
        case SEL is
            when "00" => Y <= D0;
            when "01" => Y <= D1;
            when "10" => Y <= D2;
            when "11" => Y <= D3;
            when others => Y <= (others => '0');
        end case;
    end process;
end Behavioral;