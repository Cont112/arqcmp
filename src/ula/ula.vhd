library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port(   A, B : in unsigned(15 downto 0); --Entrada da ula onde B sempre é o acumulador.
            ulaOP    : in unsigned(1 downto 0);
            saida    : out unsigned(15 downto 0);
            carry    : out std_logic;
            negative : out std_logic;
            zero     : out std_logic
    );
end ula;

architecture a_ula of ula is
    signal soma,subt,xor_gate,saidaTemp : unsigned(15 downto 0);
    --signal multi32 : unsigned(31 downto 0);
    signal x17, y17, soma17,sub17: unsigned(16 downto 0);
    begin

    x17<= '0' & A;
    y17<= '0' & B;
    
    soma17<= x17 + y17;
    sub17<= x17 - y17;
    soma<= soma17(15 downto 0);
    subt<= sub17(15 downto 0);

    carry<=soma17(16) when ulaOP = "00" else
           sub17(16) when ulaOP = "01" else
           '0';

    xor_gate<= A xor B;

    saidaTemp <= soma when ulaOP = "00" else
             subt when ulaOP = "01" else
             xor_gate when ulaOP = "10" else 
             B when ulaOP = "11" else --Caso de Load?
             "0000000000000000";
    

    zero <= '1' when saidaTemp = "0000000000000000" and ulaOP= "01" else '0';
    
    negative <= saidaTemp(15); --Ver ultimo bit do complement de dois para saber se é negativo

    saida <= saidaTemp;
end architecture;