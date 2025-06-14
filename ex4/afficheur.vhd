library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity afficheur is
    Port (
        CLK : in std_logic;
        SEG : out std_logic_vector(6 downto 0); 
        AN  : out std_logic_vector(3 downto 0)  
    );
end afficheur;

architecture Behavioral of afficheur is
    signal cnt : std_logic_vector(15 downto 0) := (others => '0');
    signal sel : std_logic_vector(1 downto 0) := "00";
begin

    
    process (CLK)
    begin
        if rising_edge(CLK) then
            cnt <= cnt + 1;
            sel <= cnt(15 downto 14); 
        end if;
    end process;

    
    process (sel)
    begin
        case sel is
            when "00" =>
                AN <= "1110"; -- AN0 actif
                SEG <= "1001111"; -- chiffre 1
            when "01" =>
                AN <= "1101"; -- AN1 actif
                SEG <= "1001111";
            when "10" =>
                AN <= "1011"; -- AN2 actif
                SEG <= "1001111";
            when "11" =>
                AN <= "0111"; -- AN3 actif
                SEG <= "1001111";
            when others =>
                AN <= "1111";
                SEG <= "1111111";
        end case;
    end process;

end Behavioral;
