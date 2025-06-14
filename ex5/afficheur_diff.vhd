library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity afficheur_diff is
    Port (
        CLK : in std_logic;
        SEG : out std_logic_vector(6 downto 0); -- CA à CG
        AN  : out std_logic_vector(3 downto 0)  -- AN0 à AN3
    );
end afficheur_diff;

architecture Behavioral of afficheur_diff is
    signal cnt : std_logic_vector(15 downto 0) := (others => '0');
    signal sel : std_logic_vector(1 downto 0) := "00";
    type digit_array is array(0 to 3) of std_logic_vector(6 downto 0);

    
    constant chiffres : digit_array := (
        "1001111", -- 1
        "0100100", -- 2
        "0000110", -- 3
        "1000011"  -- 4
    );
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
                AN <= "0111"; SEG <= chiffres(3);
            when "01" =>
                AN <= "1011"; SEG <= chiffres(2);
            when "10" =>
                AN <= "1101"; SEG <= chiffres(1);
            when "11" =>
                AN <= "1110"; SEG <= chiffres(0);
            when others =>
                AN <= "1111"; SEG <= "1111111";
        end case;
    end process;

end Behavioral;
