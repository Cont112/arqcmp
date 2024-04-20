library ieee;
use ieee.std_logic_1164.all;

entity mux8x1_tb is
end;

architecture a_mux8x1_tb of mux8x1_tb is
    component mux8x1
        port(   sel0, sel1, sel2     : in std_logic;
                entr0, entr1, entr2, entr3, entr4, entr5,
                entr6, entr7 : in std_logic;
                saida   : out std_logic 
            );
    end component;

    signal sel0,sel1,sel2 : std_logic;
    signal entr0,entr1,entr2,entr3,entr4,entr5,entr6,entr7 : std_logic;
    signal saida : std_logic;
    begin
        uut: mux8x1 port map (sel0=>sel0,
        sel1=>sel1,
        sel2=>sel2,
        entr0=>'0',
        entr1=>'0',
        entr2=>entr2,
        entr3=>'1',
        entr4=>entr4,
        entr5=>'0',
        entr6=>entr6,
        entr7=>'1',
        saida=>saida);

        process
            begin
                entr2 <='0';
                entr4 <='1';
                entr6 <='0';
                sel0 <= '0';
                sel1 <= '0';
                sel2 <= '0';
                wait for 50 ns;
                entr2 <='0';
                entr4 <='1';
                entr6 <='1';
                sel0 <= '1';
                sel1 <= '0';
                sel2 <= '0';
                wait for 50 ns;
                entr2 <='1';
                entr4 <='1';
                entr6 <='0';
                sel0 <= '0';
                sel1 <= '1';
                sel2 <= '0';
                wait for 50 ns;
                entr2 <='1';
                entr4 <='0';
                entr6 <='0';
                sel0 <= '1';
                sel1 <= '1';
                sel2 <= '0';
                wait for 50 ns;
                entr2 <='1';
                entr4 <='0';
                entr6 <='0';
                sel0 <= '1';
                sel1 <= '0';
                sel2 <= '1';
                wait for 50 ns;
                entr2 <='0';
                entr4 <='1';
                entr6 <='0';
                sel0 <= '1';
                sel1 <= '0';
                sel2 <= '1';
                wait for 50 ns;
                entr2 <='1';
                entr4 <='1';
                entr6 <='0';
                sel0 <= '0';
                sel1 <= '1';
                sel2 <= '1';
                wait for 50 ns;
                entr2 <='0';
                entr4 <='1';
                entr6 <='1';
                sel0 <= '1';
                sel1 <= '1';
                sel2 <= '1';
                wait for 50 ns;
                wait;
                end process; 
end architecture;