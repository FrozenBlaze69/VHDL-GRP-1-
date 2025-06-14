library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        btnU   : in  std_logic;
        btnD   : in  std_logic;
        btnL   : in  std_logic;
        btnR   : in  std_logic;
        RED    : out std_logic_vector(3 downto 0);
        GREEN  : out std_logic_vector(3 downto 0);
        BLUE   : out std_logic_vector(3 downto 0);
        HS     : out std_logic;
        VS     : out std_logic
    );
end top;

architecture Behavioral of top is
    signal pixel_clk : std_logic;
    signal hc, vc    : std_logic_vector(10 downto 0);
    signal blank     : std_logic;
begin
    div_inst : entity work.div_25MHz
        port map (
            clk     => clk,
            rst     => rst,
            clk_out => pixel_clk
        );

    vga_ctrl : entity work.vga_controller_640_60
        port map (
            pixel_clk => pixel_clk,
            rst       => rst,
            hcount    => hc,
            vcount    => vc,
            blank     => blank,
            HS        => HS,
            VS        => VS
        );

    snake_disp : entity work.snake_display
        port map (
            clk   => pixel_clk,
            rst   => rst,
            hc    => hc,
            vc    => vc,
            blank => blank,
            btnU  => btnU,
            btnD  => btnD,
            btnL  => btnL,
            btnR  => btnR,
            RED   => RED,
            GREEN => GREEN,
            BLUE  => BLUE
        );
end Behavioral;
