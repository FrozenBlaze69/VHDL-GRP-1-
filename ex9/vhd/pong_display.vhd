library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pong_display is
    Port (
        clk   : in std_logic;
        rst   : in std_logic;
        hc    : in std_logic_vector(10 downto 0);
        vc    : in std_logic_vector(10 downto 0);
        blank : in std_logic;
        btnU  : in std_logic;
        btnD  : in std_logic;
        btnL  : in std_logic;
        btnR  : in std_logic;
        RED   : out std_logic_vector(3 downto 0);
        GREEN : out std_logic_vector(3 downto 0);
        BLUE  : out std_logic_vector(3 downto 0)
    );
end pong_display;

architecture Behavioral of pong_display is
    constant RACKET_W     : integer := 10;
    constant RACKET_H     : integer := 60;
    constant RACKET_L_X   : integer := 100;
    constant RACKET_R_X   : integer := 530;
    constant BALL_SIZE    : integer := 8;

    signal ball_x     : integer := 320;
    signal ball_y     : integer := 240;
    signal ball_dx    : integer := 1;
    signal ball_dy    : integer := 1;

    signal racket_L_y : integer := 200;
    signal racket_R_y : integer := 200;

    signal tick : integer := 0;
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                ball_x      <= 320;
                ball_y      <= 240;
                ball_dx     <= 1;
                ball_dy     <= 1;
                racket_L_y  <= 200;
                racket_R_y  <= 200;
                tick        <= 0;
            else
                tick <= tick + 1;
                if tick = 200000 then
                    tick <= 0;

                    
                    if btnU = '1' and racket_L_y > 0 then
                        racket_L_y <= racket_L_y - 5;
                    elsif btnD = '1' and racket_L_y < 480 - RACKET_H then
                        racket_L_y <= racket_L_y + 5;
                    end if;

                    if btnL = '1' and racket_R_y > 0 then
                        racket_R_y <= racket_R_y - 5;
                    elsif btnR = '1' and racket_R_y < 480 - RACKET_H then
                        racket_R_y <= racket_R_y + 5;
                    end if;

                    
                    ball_x <= ball_x + ball_dx;
                    ball_y <= ball_y + ball_dy;


if (ball_y <= 0) and (ball_dy < 0) then
    ball_y  <= 0;
    ball_dy <= -ball_dy;
end if;

-- je v exploser svp qq peut regarder pr le rebond de la balle sur les murs
if (ball_y + BALL_SIZE >= 479) and (ball_dy > 0) then
    ball_y  <= 479 - BALL_SIZE;
    ball_dy <= -ball_dy;
end if;


                    
                    if (ball_x <= RACKET_L_X + RACKET_W) and
                       (ball_x >= RACKET_L_X) and
                       (ball_y + BALL_SIZE >= racket_L_y) and
                       (ball_y <= racket_L_y + RACKET_H) then
                        ball_dx <= 1;
                    end if;

                    
                    if (ball_x + BALL_SIZE >= RACKET_R_X) and
                       (ball_x + BALL_SIZE <= RACKET_R_X + RACKET_W) and
                       (ball_y + BALL_SIZE >= racket_R_y) and
                       (ball_y <= racket_R_y + RACKET_H) then
                        ball_dx <= -1;
                    end if;

                    
                    if ball_x < 0 or ball_x > 640 then
                        ball_x  <= 320;
                        ball_y  <= 240;
                        ball_dx <= -ball_dx;
                        ball_dy <= 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    process(hc, vc, blank)
    begin
        if blank = '1' then
            RED   <= "0000";
            GREEN <= "0000";
            BLUE  <= "0000";
        else
            if (to_integer(unsigned(hc)) >= RACKET_L_X and to_integer(unsigned(hc)) < RACKET_L_X + RACKET_W) and
               (to_integer(unsigned(vc)) >= racket_L_y and to_integer(unsigned(vc)) < racket_L_y + RACKET_H) then
                RED   <= "0000"; GREEN <= "1111"; BLUE  <= "0000";

            elsif (to_integer(unsigned(hc)) >= RACKET_R_X and to_integer(unsigned(hc)) < RACKET_R_X + RACKET_W) and
                  (to_integer(unsigned(vc)) >= racket_R_y and to_integer(unsigned(vc)) < racket_R_y + RACKET_H) then
                RED   <= "0000"; GREEN <= "0000"; BLUE  <= "1111";

            elsif (to_integer(unsigned(hc)) >= ball_x and to_integer(unsigned(hc)) < ball_x + BALL_SIZE) and
                  (to_integer(unsigned(vc)) >= ball_y and to_integer(unsigned(vc)) < ball_y + BALL_SIZE) then
                RED   <= "1111"; GREEN <= "1111"; BLUE  <= "1111";

            elsif (to_integer(unsigned(hc)) > 318 and to_integer(unsigned(hc)) < 322) and
                  (to_integer(unsigned(vc)) mod 20 < 10) then
                RED   <= "1111"; GREEN <= "1111"; BLUE  <= "1111";

            else
                RED   <= "0000"; GREEN <= "0000"; BLUE  <= "0000";
            end if;
        end if;
    end process;

end Behavioral;
