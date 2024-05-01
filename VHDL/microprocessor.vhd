library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessor is
    port(
        ula_op_sel : in unsigned (2 downto 0);
        ula_carry, ula_zero : out std_logic;
        ula_saida : out unsigned (15 downto 0);
        reg_a, reg_b, reg_write : in unsigned (2 downto 0);
        imediato: in unsigned(15 downto 0);
        im_sel: in std_logic;
        clk,rst,wr_en : in std_logic
    );
end entity;

architecture a_microprocessor of microprocessor is
    component bank8reg is
        port(read_register1 : in unsigned(2 downto 0);
        read_register2 : in unsigned(2 downto 0);
        write_register : in unsigned(2 downto 0);
        write_data     : in unsigned(15 downto 0);
        read_data1     : out unsigned(15 downto 0);
        read_data2     : out unsigned(15 downto 0);
        clk            : in std_logic;
        rst            : in std_logic;
        wr_en          : in std_logic
        );
        end component;

    component ula is
        port(   A, B : in unsigned(15 downto 0);
        ulaOP    : in unsigned(2 downto 0);
        saida    : out unsigned(15 downto 0);
        carry    : out std_logic;
        zero     : out std_logic
        );
    end component;

    component mux1x2 is
        port(sel : in std_logic;
        entr0,entr1: in unsigned(15 downto 0);
        saida: out unsigned(15 downto 0)
        ); 
    end component;

signal  entr_ula_mux, saida_ula,
        data1, data2 : unsigned(15 downto 0);

begin

    registradores: bank8reg port map (  read_register1 => reg_a, read_register2 => reg_b, write_register => reg_write,
                                        write_data => saida_ula, clk => clk, rst=> rst, wr_en =>wr_en, 
                                        read_data1 => data1, read_data2 => data2
    );

    ula2: ula port map (A => data1, B => entr_ula_mux, 
        ulaOP=> ula_op_sel, carry => ula_carry, zero => ula_zero, saida => saida_ula
    );

    mux: mux1x2 port map(
        sel => im_sel, entr0 =>data2 , entr1=> imediato, saida => entr_ula_mux
    );

    ula_saida <= saida_ula;

    
end architecture;