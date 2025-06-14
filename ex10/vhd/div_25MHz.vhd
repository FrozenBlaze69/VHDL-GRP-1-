library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_25MHz is
    Port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        clk_out : out std_logic
    );
end div_25MHz;

architecture Behavioral of div_25MHz is
    signal counter : std_logic_vector(1 downto 0) := "00";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                counter <= "00";
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= counter(1);
end Behavioral;
