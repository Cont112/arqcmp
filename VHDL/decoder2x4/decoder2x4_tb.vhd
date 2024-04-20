library ieee;
use ieee.std_logic_1164.all;

entity decoder2x4_tb is
end;

architecture a_decoder2x4_tb of decoder2x4_tb is
    component decoder2x4
        port(   in_x0: in std_logic;
                in_x1: in std_logic;
                out_y0: out std_logic;
                out_y1: out std_logic;
                out_y2: out std_logic;
                out_y3: out std_logic
        );
    end component;
    signal in_x0,in_x1,out_y0,out_y1,out_y2,out_y3: std_logic;
    begin
            uut: decoder2x4 port map (  in_x0 => in_x0,
                                        in_x1 => in_x1,
                                        out_y0 => out_y0,
                                        out_y1 => out_y1,
                                        out_y2 => out_y2,
                                        out_y3 => out_y3);
            process
            begin
                in_x0<= '0';
                in_x1<= '0';
                wait for 50 ns;
                in_x0<= '1';
                in_x1<= '0';
                wait for 50 ns;
                in_x0<= '0';
                in_x1<='1';
                wait for 50 ns;
                in_x0<='1';
                in_x1<='1';
                wait for 50 ns;
                wait;
            end process;
        end architecture;