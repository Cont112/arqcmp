library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ula_tb is
end ula_tb;


architecture a_ula_tb of ula_tb is
    component ula is 
    port(   A, B : in unsigned(15 downto 0);
            ulaOP    : in unsigned(2 downto 0);
            saida    : out unsigned(15 downto 0);
            carry    : out std_logic;
            zero     : out std_logic
    );
    end component;

    signal A, B : unsigned(15 downto 0);
    signal saida : unsigned(15 downto 0);
    signal ulaOP : unsigned(2 downto 0);
    signal carry,zero : std_logic;
begin
    ula1: ula port map(
        A => A,
        B => B,
        saida => saida,
        carry => carry,
        zero => zero,
        ulaOP => ulaOP
    );
    process 
    begin
        ulaop <= "000";--            SOMA COM CARRY
        A<= "1000010000000110"; 
        B<= "1000000000001000"; 
        wait for 50 ns;
        ulaop <= "000";--            SOMA
        A<= "0000010000000110"; 
        B<= "0000000000001000"; 
        wait for 50 ns;
        ulaop <= "000";--            SOMA
        A<= "0000000000000000"; 
        B<= "0000000000000000"; 
        wait for 50 ns;
        ulaop <= "001";--            SUBTRAÇÃO
        A<= "0000000011111000"; 
        B<= "0000000011100100"; 
        wait for 50 ns;
        ulaop <= "001";--            SUBTRAÇÃO
        A<= "0000000011111000"; 
        B<= "0000000111100100"; 
        wait for 50 ns;
        ulaop <= "001";--            SUBTRAÇÃO
        A<= "0000000011111000"; 
        B<= "0000000011111000"; 
        wait for 50 ns;
        ulaop <= "010";--            MULTIPLICAÇÃO
        A<= "0000000001100100"; 
        B<= "0000000001100100"; 
        wait for 50 ns;
        ulaop <= "010";--            MULTIPLICAÇÃO
        A<= "1000000001100100"; 
        B<= "1000000001100100"; 
        wait for 50 ns;
        ulaop <= "011";--            OR
        A<= "1011010011011001"; 
        B<= "0100101100100111";
        wait for 50 ns;
        ulaop <= "011";--            OR
        A<= "0000000001011001"; 
        B<= "0000010000000001";
        wait for 50 ns;
        ulaop <= "100";--            AND
        A<= "0000000001011001"; 
        B<= "0000000001011001";
        wait for 50 ns;
        ulaop <= "100";--            AND
        A<= "0010001001011001"; 
        B<= "0100101000000001";
        wait for 50 ns;
        ulaop <= "101";--            NAND
        A<= "0000100101011001"; 
        B<= "0100001000001001";
        wait for 50 ns;
        ulaop <= "101";--            NAND
        A<= "1000100010101101"; 
        B<= "0000100010000101";
        wait for 50 ns;
        ulaop <= "110";--            XOR
        A<= "1001001001011001"; 
        B<= "1001000010010101";
        wait for 50 ns;
        ulaop <= "110";--            XOR
        A<= "1001001001011001"; 
        B<= "0000000000000000";
        wait for 50 ns;
        wait;
    end process;
end architecture;