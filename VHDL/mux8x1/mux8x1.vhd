library ieee;
use ieee.std_logic_1164.all;

entity mux8x1 is
        port(   sel0,sel1,sel2     : in std_logic;
                entr0,entr1,entr2,entr3,
                entr4,entr5,entr6,entr7 : in std_logic;
                saida   : out std_logic
        );
end entity;

architecture a_mux8x1 of mux8x1 is
begin
     saida <=   entr0 when sel2='0' and sel1='0' and sel0='0' else
                entr1 when sel2='0' and sel1='0' and sel0='1' else
                entr2 when sel2='0' and sel1='1' and sel0='0' else
                entr3 when sel2='0' and sel1='1' and sel0='1' else
                entr4 when sel2='1' and sel1='0' and sel0='0' else
                entr5 when sel2='1' and sel1='0' and sel0='1' else
                entr6 when sel2='1' and sel1='1' and sel0='0' else
                entr7 when sel2='1' and sel1='1' and sel0='1' else
                '0';
end architecture;

