library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity image_top is
    Port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        HS    : out std_logic;
        VS    : out std_logic;
        RED   : out std_logic_vector(3 downto 0);
        GREEN : out std_logic_vector(3 downto 0);
        BLUE  : out std_logic_vector(3 downto 0)
    );
end image_top;

architecture Behavioral of image_top is
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
            rst       => rst,
            pixel_clk => pixel_clk,
            HS        => HS,
            VS        => VS,
            hcount    => hc,
            vcount    => vc,
            blank     => blank
        );

    image_gen : entity work.image
        port map (
            hc    => hc,
            vc    => vc,
            blank => blank,
            red   => RED,
            green => GREEN,
            blue  => BLUE
        );

end Behavioral;
