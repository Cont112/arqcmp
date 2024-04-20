library ieee;
use ieee.std_logic_1164.all;

entity decoder2x4 is 
    port(   in_x0: in std_logic;
            in_x1: in std_logic;
            out_y0: out std_logic;
            out_y1: out std_logic;
            out_y2: out std_logic;
            out_y3: out std_logic
    );
end entity;

architecture a_decoder2x4 of decoder2x4 is
begin
    out_y0<= not in_x0 and not in_x1;
    out_y1<= not in_x1 and in_x0;
    out_y2<= in_x1 and not in_x0;
    out_y3<= in_x0 and in_x1;
end architecture;