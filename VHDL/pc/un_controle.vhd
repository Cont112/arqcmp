library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity  un_controle is
    port(data_in: in unsigned(31 downto 0);
         instr_in : in unsigned (6 downto 0);
         instr_out: out unsigned (6 downto 0);
         state: in std_logic
    );
end entity;

architecture a_un_controle of un_controle is
signal opcode: unsigned(1 downto 0);
signal instr_jump : unsigned (6 downto 0);
signal jump_en : std_logic;
begin
    instr_jump <= data_in(31 downto 25);
    opcode <= data_in(6 downto 5);
    jump_en <= '1' when opcode="11" else
               '0';

    instr_out <= instr_jump when jump_en ='1' else 
                instr_in + 1 when state = '1' else
                 instr_in when state = '0' else
                 "0000000";
end architecture;