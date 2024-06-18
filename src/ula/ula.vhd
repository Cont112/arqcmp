library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port(   A, B : in unsigned(15 downto 0); --Entrada da ula onde B sempre é o acumulador.
            ulaOP    : in unsigned(1 downto 0);
            borrow_in : in std_logic;
            saida    : out unsigned(15 downto 0);
            carry    : out std_logic;
            negative : out std_logic;
            zero     : out std_logic
    );
end ula;

architecture a_ula of ula is
    signal soma,subt,saidaTemp, subb: unsigned(15 downto 0);
    signal ctz: unsigned(4 downto 0);
    --signal multi32 : unsigned(31 downto 0);
    signal x17, y17, soma17,sub17: unsigned(16 downto 0);

    begin

    x17<= '0' & A;
    y17<= '0' & B;
    
    soma17<= x17 + y17;
    sub17<= x17 - y17;
    soma<= soma17(15 downto 0);
    subt<= sub17(15 downto 0);

    subb <= A - B - 1 WHEN borrow_in = '1' ELSE
    A - B;

    carry<=soma17(16) when ulaOP = "00" else
           sub17(16) when ulaOP = "01" else
           '0';


    ctz <= "10000" when A(15 downto 0) = "0000000000000000" else
    "01111" when A(14 downto 0) = "000000000000000" else
    "01110" when A(13 downto 0) = "00000000000000" else
    "01101" when A(12 downto 0) = "0000000000000" else
    "01100" when A(11 downto 0) = "000000000000" else
    "01011" when A(10 downto 0) = "00000000000" else
    "01010" when A(9 downto 0) = "0000000000" else
    "01001" when A(8 downto 0) = "000000000" else
    "01000" when A(7 downto 0) = "00000000" else
    "00111" when A(6 downto 0) = "0000000" else
    "00110" when A(5 downto 0) = "000000" else
    "00101" when A(4 downto 0) = "00000" else
    "00100" when A(3 downto 0) = "0000" else
    "00011" when A(2 downto 0) = "000" else
    "00010" when A(1 downto 0) = "00" else
    "00001" when A(0) = '0' else
    "00000";

    saidaTemp <= soma when ulaOP = "00" else
             subt when ulaOP = "01" else
             subb when ulaOP = "10" else 
             ("00000000000" & ctz) when ulaOP = "11" else
             "0000000000000000";
    

    zero <= '1' when saidaTemp = "0000000000000000" and ulaOP= "01" else '0';
    
    negative <= saidaTemp(15); --Ver ultimo bit do complement de dois para saber se é negativo

    saida <= saidaTemp;
end architecture;