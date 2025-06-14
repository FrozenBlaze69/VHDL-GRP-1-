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
    signal count : std_logic_vector(1 downto 0) := "00"; 
begin
    process(clk, rst)
    begin
        if rst = '1' then
            count <= "00";
        elsif rising_edge(clk) then
            count <= count + 1;
        end if;
    end process;

    clk_out <= count(1); 

end Behavioral;
