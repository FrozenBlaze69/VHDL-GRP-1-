----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2025 14:29:10
-- Design Name: 
-- Module Name: Ex1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ex1 is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           LED : out std_logic_vector(15 downto 0)
           );
end Ex1;

architecture Behavioral of Ex1 is
signal cnt : unsigned (23 downto 0);
signal led_index : unsigned(3 downto 0);
signal leds : unsigned(15 downto 0);
begin

    process(CLK) is
    begin
        if(RST = '1') then
        cnt <= (others => '0');
        elsif (rising_edge(CLK)) then
            cnt <= cnt + 1;
        end if;
    end process;
    
    led_index <= cnt(23 downto 20);
    
    process(led_index)
    begin
        leds <= (others => '0');
        leds(to_integer(led_index)) <= '1';
    end process;
    
    LED <= std_logic_vector(leds);
end Behavioral;
