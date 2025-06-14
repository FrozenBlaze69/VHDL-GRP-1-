library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity image is
    Port (
        hc    : in std_logic_vector(10 downto 0);
        vc    : in std_logic_vector(10 downto 0);
        blank : in std_logic;
        red   : out std_logic_vector(3 downto 0);
        green : out std_logic_vector(3 downto 0);
        blue  : out std_logic_vector(3 downto 0)
    );
end image;

architecture Behavioral of image is
begin
    process(hc, vc, blank)
        variable x : integer;
    begin
        x := to_integer(unsigned(hc));  

        if blank = '1' then
            red   <= "0000";
            green <= "0000";
            blue  <= "0000";
        else
            if x < 213 then  -- Bande bleue
                red   <= "0000";
                green <= "0000";
                blue  <= "1111";
            elsif x < 426 then  -- Bande blanche
                red   <= "1111";
                green <= "1111";
                blue  <= "1111";
            else  -- Bande rouge
                red   <= "1111";
                green <= "0000";
                blue  <= "0000";
            end if;
        end if;
    end process;
end Behavioral;
