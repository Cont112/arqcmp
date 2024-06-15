library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ula_tb is
end ula_tb;


architecture a_ula_tb of ula_tb is
    component ula is 
    port(   A, B : in unsigned(15 downto 0);
            ulaOP    : in unsigned(1 downto 0);
            saida    : out unsigned(15 downto 0);
            carry    : out std_logic;
            negative : out std_logic;
            zero     : out std_logic
    );
    end component;

    signal A, B : unsigned(15 downto 0);
    signal saida : unsigned(15 downto 0);
    signal ulaOP : unsigned(1 downto 0);
    signal carry,negative,zero : std_logic;
begin
    ula1: ula port map(
        A => A,
        B => B,
        saida => saida,
        carry => carry,
        zero => zero,
        negative => negative,
        ulaOP => ulaOP
    );
    process 
    begin
        ulaop <= "11";--            SOMA COM CARRY
        A<= "1000010000100000"; 
        B<= "1000000000001000"; 
        wait for 50 ns;
        ulaop <= "11";--            SOMA
        A<= "0000010000010110"; 
        B<= "0000000000010000"; 
        wait for 50 ns;
        wait;
    end process;
end architecture;