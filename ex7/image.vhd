library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity image is
    Port (
        hc    : in  std_logic_vector(10 downto 0); 
        vc    : in  std_logic_vector(10 downto 0); 
        blank : in  std_logic;
        red   : out std_logic_vector(3 downto 0);
        green : out std_logic_vector(3 downto 0);
        blue  : out std_logic_vector(3 downto 0)
    );
end image;

architecture Behavioral of image is
begin
    process(hc, vc, blank)
    begin
        if blank = '1' then
            red   <= (others => '0');
            green <= (others => '0');
            blue  <= (others => '0');
        else
            red   <= "1111";  
            green <= "0000";
            blue  <= "0000";
        end if;
    end process;
end Behavioral;