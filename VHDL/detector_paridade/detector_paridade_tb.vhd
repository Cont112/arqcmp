library ieee;
use ieee.std_logic_1164.all;

entity detector_paridade_tb is
end;

architecture a_detector_paridade_tb of detector_paridade_tb is 
    component detector_paridade
        port(   x0: in std_logic;
                x1: in std_logic;
                x2: in std_logic;
                y0: out std_logic
        );
    end component;
    signal x0,x1,x2,y0: std_logic;
    begin
        uut: detector_paridade port map (   x0=>x0,
                                            x1=>x1,
                                            x2=>x2,
                                            y0=>y0);
        process
        begin
            x0<='0';
            x1<='0';
            x2<='0';
            wait for 50 ns;
            x0<='1';
            x1<='0';
            x2<='0';
            wait for 50 ns;
            x0<='0';
            x1<='1';
            x2<='0';
            wait for 50 ns;
            x0<='1';
            x1<='1';
            x2<='0';
            wait for 50 ns;
            x0<='0';
            x1<='0';
            x2<='1';
            wait for 50 ns;
            x0<='1';
            x1<='0';
            x2<='1';
            wait for 50 ns;
            x0<='0';
            x1<='1';
            x2<='1';
            wait for 50 ns;
            x0<='1';
            x1<='1';
            x2<='1';
            wait for 50 ns;
            wait;
            end process;
        end architecture;