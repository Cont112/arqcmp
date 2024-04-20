library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port(   A, B : in unsigned(15 downto 0);
            ulaOP    : in unsigned(2 downto 0);
            saida    : out unsigned(15 downto 0);
            carry    : out std_logic;
            zero     : out std_logic
    );
end ula;

architecture a_ula of ula is
    component aritmetica is 
        port(  x,y : in unsigned(15 downto 0);
            soma,subt,multi,xor_gate,and_gate,or_gate,nand_gate: out unsigned(15 downto 0);
            carry : out std_logic
        );
    end component;

    signal soma, subt,multi,xor_gate,and_gate,or_gate,nand_gate
    ,saidaTemp : unsigned(15 downto 0);
    begin
    uut: aritmetica port map(
        x=>A, y=>B, soma=>soma, subt=>subt,
        carry=>carry, multi=>multi,
        xor_gate=>xor_gate, and_gate=>and_gate,or_gate=>or_gate,nand_gate=>nand_gate
    );

    saidaTemp <= soma when ulaOP = "000" else
             subt when ulaOP = "001" else
             multi when ulaOP = "010" else
             or_gate when ulaOP = "011" else
             and_gate when ulaOP = "100" else
             nand_gate when ulaOP = "101" else
             xor_gate when ulaOP = "110" else
             "0000000000000000";
    saida <= saidaTemp;
    zero <= '1' when saidaTemp = "0000000000000000" else '0';
end architecture;