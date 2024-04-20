library ieee;
use ieee.std_logic_1164.all;

entity detector_paridade is
    port(   x0: in std_logic;
            x1: in std_logic;
            x2: in std_logic;
            y0: out std_logic);
end entity;

architecture a_detector_paridade of detector_paridade is 
begin
    y0 <= (x0 xor x1) xor x2;
end architecture;