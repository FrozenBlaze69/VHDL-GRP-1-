library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity snake_display is
    Port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        hc    : in  std_logic_vector(10 downto 0);
        vc    : in  std_logic_vector(10 downto 0);
        blank : in  std_logic;
        btnU  : in  std_logic;
        btnD  : in  std_logic;
        btnL  : in  std_logic;
        btnR  : in  std_logic;
        RED   : out std_logic_vector(3 downto 0);
        GREEN : out std_logic_vector(3 downto 0);
        BLUE  : out std_logic_vector(3 downto 0)
    );
end snake_display;

architecture Behavioral of snake_display is
    constant SCREEN_WIDTH  : integer := 640;
    constant SCREEN_HEIGHT : integer := 480;
    constant CELL_SIZE     : integer := 32;
    constant GRID_WIDTH    : integer := SCREEN_WIDTH / CELL_SIZE;  -- 20
    constant GRID_HEIGHT   : integer := SCREEN_HEIGHT / CELL_SIZE; -- 15
    constant MAX_LENGTH    : integer := 128;

    type pos_array is array (0 to MAX_LENGTH-1) of std_logic_vector(13 downto 0);
    signal body_mem : pos_array;
    signal length   : integer range 1 to MAX_LENGTH := 4;

    signal head_x : integer range 0 to 19 := 10;
    signal head_y : integer range 0 to 14 := 7;
    signal dir_x, dir_y : integer range -1 to 1 := 1;
    signal move_tick : integer range 0 to 5000000 := 0;

    signal food_x : integer range 0 to 19 := 5;
    signal food_y : integer range 0 to 14 := 5;

    signal collision : std_logic := '0';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' or collision = '1' then
                head_x <= 10;
                head_y <= 7;
                dir_x <= 1;
                dir_y <= 0;
                length <= 4;
                for i in 0 to MAX_LENGTH-1 loop
                    body_mem(i) <= (others => '0');
                end loop;
                food_x <= 5;
                food_y <= 5;
                move_tick <= 0;
                collision <= '0';
            else
                if btnU = '1' and dir_y /= 1 then dir_x <= 0; dir_y <= -1; end if;
                if btnD = '1' and dir_y /= -1 then dir_x <= 0; dir_y <= 1; end if;
                if btnL = '1' and dir_x /= 1 then dir_x <= -1; dir_y <= 0; end if;
                if btnR = '1' and dir_x /= -1 then dir_x <= 1; dir_y <= 0; end if;

                if move_tick = 5_000_000 then
                    move_tick <= 0;

                    for i in MAX_LENGTH-1 downto 1 loop
                        if i < length then
                            body_mem(i) <= body_mem(i-1);
                        end if;
                    end loop;

                    body_mem(0)(13 downto 7) <= conv_std_logic_vector(head_x, 7);
                    body_mem(0)(6 downto 0)  <= conv_std_logic_vector(head_y, 7);

                    head_x <= head_x + dir_x;
                    head_y <= head_y + dir_y;

                    if head_x >= GRID_WIDTH or head_y >= GRID_HEIGHT or head_x < 0 or head_y < 0 then
                        collision <= '1';
                    end if;

                    for i in 1 to MAX_LENGTH-1 loop
                        if i < length then
                            if conv_integer(body_mem(i)(13 downto 7)) = head_x and
                               conv_integer(body_mem(i)(6 downto 0))  = head_y then
                                collision <= '1';
                            end if;
                        end if;
                    end loop;

                    if head_x = food_x and head_y = food_y then
                        if length < MAX_LENGTH then
                            length <= length + 1;
                        end if;
                        food_x <= (food_x + 3) mod GRID_WIDTH;
                        food_y <= (food_y + 5) mod GRID_HEIGHT;
                    end if;
                else
                    move_tick <= move_tick + 1;
                end if;
            end if;
        end if;
    end process;

    process(hc, vc, blank)
        variable pixel_x : integer := 0;
        variable pixel_y : integer := 0;
        variable cell_x  : integer := 0;
        variable cell_y  : integer := 0;
        variable in_snake, in_head, in_food : boolean := false;
    begin
        RED   <= "0000";
        GREEN <= "0000";
        BLUE  <= "0000";

        if blank = '0' then
            pixel_x := conv_integer(hc);
            pixel_y := conv_integer(vc);

            cell_x := pixel_x / CELL_SIZE;
            cell_y := pixel_y / CELL_SIZE;

            in_snake := false;
            in_head := false;
            in_food := false;

            for i in 1 to MAX_LENGTH-1 loop
                if i < length then
                    if conv_integer(body_mem(i)(13 downto 7)) = cell_x and
                       conv_integer(body_mem(i)(6 downto 0))  = cell_y then
                        in_snake := true;
                    end if;
                end if;
            end loop;

            if head_x = cell_x and head_y = cell_y then
                in_head := true;
            end if;

            if food_x = cell_x and food_y = cell_y then
                in_food := true;
            end if;

if in_head then
    RED   <= "1111"; 
    GREEN <= "0000"; 
    BLUE  <= "0000";
elsif in_snake then
    RED   <= "1111"; 
    GREEN <= "0110"; 
    BLUE  <= "0000";
elsif in_food then
    RED   <= "0000";
    GREEN <= "0000";
    BLUE  <= "1111";
else
    if (cell_x + cell_y) mod 2 = 0 then
        RED   <= "0000";
        GREEN <= "1111"; -- vert clair
        BLUE  <= "0000";
    else
        RED   <= "0000";
        GREEN <= "0101"; -- vert foncé
        BLUE  <= "0000";
    end if;
end if;


        end if;
    end process;

end Behavioral;
