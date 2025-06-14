library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity chrono is
    Port (
        CLK   : in std_logic;
        RESET : in std_logic;
        SEG   : out std_logic_vector(7 downto 0);
        AN    : out std_logic_vector(3 downto 0)
    );
end chrono;

architecture Structural of chrono is
    type digit_array is array (0 to 3) of std_logic_vector(3 downto 0);
    signal pulse_1s : std_logic;
    signal digits : digit_array;
    signal rco0, rco1, rco2 : std_logic;
    signal sel : std_logic_vector(1 downto 0);
    signal selected_digit : std_logic_vector(3 downto 0);
    signal cnt_refresh : std_logic_vector(15 downto 0) := (others => '0');
begin

    div1s : entity work.diviseur
        port map (
            CLK => CLK,
            RESET => RESET,
            pulse_1s => pulse_1s
        );

    c0 : entity work.compteur_modulo
        generic map (N => 10)
        port map (
            CLK => CLK,
            RESET => RESET,
            EN => pulse_1s,
            Q => digits(0),
            RCO => rco0
        );

    c1 : entity work.compteur_modulo
        generic map (N => 10)
        port map (
            CLK => CLK,
            RESET => RESET,
            EN => rco0,
            Q => digits(1),
            RCO => rco1
        );

    c2 : entity work.compteur_modulo
        generic map (N => 10)
        port map (
            CLK => CLK,
            RESET => RESET,
            EN => rco1,
            Q => digits(2),
            RCO => rco2
        );

    c3 : entity work.compteur_modulo
        generic map (N => 10)
        port map (
            CLK => CLK,
            RESET => RESET,
            EN => rco2,
            Q => digits(3),
            RCO => open
        );

    process(CLK)
    begin
        if rising_edge(CLK) then
            cnt_refresh <= cnt_refresh + 1;
            sel <= cnt_refresh(15 downto 14);
        end if;
    end process;

    mux_inst : entity work.mux4
        port map (
            SEL => sel,
            D0 => digits(0),
            D1 => digits(1),
            D2 => digits(2),
            D3 => digits(3),
            Y  => selected_digit
        );

    seg_decoder : entity work.decodeur_7segments
        port map (
            BIN => selected_digit,
            SEG => SEG
        );

    an_decoder : entity work.decodeur_an
        port map (
            SEL => sel,
            AN => AN
        );

end Structural;