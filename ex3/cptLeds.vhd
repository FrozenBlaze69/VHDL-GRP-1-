library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Ex3_CptLeds is
    Port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        btnL   : in  std_logic;
        btnR   : in  std_logic;
        leds   : out std_logic_vector(15 downto 0)
    );
end Ex3_CptLeds;

architecture Behavioral of Ex3_CptLeds is
    signal count : integer range 0 to 16 := 0;
    signal tempo : integer range 0 to 24_999_999 := 0; 
    signal pulse : std_logic := '0';
    signal led_temp : std_logic_vector(15 downto 0);
begin

    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                tempo <= 0;
                pulse <= '0';
            elsif tempo = 24_999_999 then
                tempo <= 0;
                pulse <= '1';
            else
                tempo <= tempo + 1;
                pulse <= '0';
            end if;
        end if;
    end process;

    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                count <= 0;
            elsif pulse = '1' then
                if btnL = '1' and count < 16 then
                    count <= count + 1;
                elsif btnR = '1' and count > 0 then
                    count <= count - 1;
                end if;
            end if;
        end if;
    end process;

    
    process(count)
    begin
        led_temp <= (others => '0');
        for i in 0 to 15 loop
            if i < count then
                led_temp(i) <= '1';
            end if;
        end loop;
    end process;

    leds <= led_temp;

end Behavioral;
