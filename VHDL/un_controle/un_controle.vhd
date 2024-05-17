library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity  un_controle is
    port(data_in: in unsigned(15 downto 0);
         instr_in : in unsigned (6 downto 0);
         instr_out: out unsigned (6 downto 0);
         state: out unsigned(1 downto 0);
         ula_op: out unsigned(2 downto 0);
         reg_a, reg_b, reg_dist: out unsigned(2 downto 0);
         imediato: out unsigned(15 downto 0);
         wr_en: out std_logic;
         im_sel: out std_logic;
         clk,rst : in std_logic
    );
end entity;

architecture a_un_controle of un_controle is
    component maq_estados is
        port( clk,rst: in std_logic;
        estado: out unsigned(1 downto 0)
    );
    end component;

signal instr_jump : unsigned (6 downto 0);
signal jump_en : std_logic;
signal imm_saida : unsigned (15 downto 0);
signal opcode: unsigned (4 downto 0);

begin
    maq: maq_estados port map(clk=>clk, rst=>rst, estado=>state);
 
    opcode <= data_in(15 downto 11);

    ula_op <= opcode(2 downto 0);

    wr_en <= opcode(3);

    im_sel <= opcode(4);

    jump_en <= '1' when opcode="10000" else --opcode de jump incondicional
               '0';


    instr_jump <= data_in(10 downto 4);
    
    imediato <= "00000000000" & data_in(4 downto 0) when data_in(4) = '0' else
                "11111111111" & data_in(4 downto 0) when data_in(4) = '1' else
                "0000000000000000"; --extensao de sinal
    
    reg_dist <= data_in(10 downto 8);
    
    reg_a <= data_in(7 downto 5);
    reg_b <= data_in(4 downto 2);

    instr_out <= instr_jump when jump_en ='1' else
                instr_in + 1;



end architecture;