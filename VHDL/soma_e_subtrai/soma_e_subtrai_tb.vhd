library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma_e_subtrai_tb is
end entity;

architecture a_soma_e_subtrai_tb of soma_e_subtrai_tb is
    component soma_e_subtrai 
        port(   x,y : in unsigned(7 downto 0);
            soma,subt : out unsigned(7 downto 0);
            maior, x_negativo : out std_logic
            );
    end component;
    signal x,y : unsigned(7 downto 0);
    signal soma, subt : unsigned(7 downto 0);
    signal maior,x_negativo : std_logic;

    begin
        uut: soma_e_subtrai port map (
            x => x,
            y => y,
            soma => soma,
            subt => subt,
            maior => maior,
            x_negativo => x_negativo
        );
        process 
        begin
            x<= "00000110"; --6
            y<= "00001000"; --8
            wait for 50 ns;
            x<= "11111000"; --248
            y<= "11100100"; --228
            wait for 50 ns;
            x<="01100100"; --100
            y<="01100100"; --100
            wait for 50 ns;
            x<="01011001"; --89
            y<="00000001";
            wait for 50 ns;
            wait;
        end process;
    end architecture;