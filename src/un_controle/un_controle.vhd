library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity  un_controle is
    port(instr_in: in unsigned(15 downto 0); --Instrucao de 16 bits
        current_addr : in unsigned (6 downto 0); -- Endereco atual
        next_addr: out unsigned (6 downto 0); -- Proximo endereco
        state: in unsigned(1 downto 0);    --Estado atual
        sel_ula: out std_logic; --Selecao de entrada da ULA
        ula_op: out unsigned(1 downto 0);   -- Operacao ULA
        reg_src, reg_dist: out unsigned(2 downto 0);  --Registradores de origem e destino (os dois podem ser o acumulador)
        imediato: out unsigned(15 downto 0); -- Imediato extendido
        wr_en_reg, wr_en_acu: out std_logic;
        wr_en_flags, wr_en_ram: out std_logic;
        sel_reg: out std_logic;
        sel_acu: out unsigned(1 downto 0);
        zero, carry, negative: in std_logic; --Flag zero e carry
        clk,rst : in std_logic --Clocks
    );
end entity;

architecture a_un_controle of un_controle is
    signal instr_jump: unsigned (6 downto 0);
    signal relative_branch: unsigned (7 downto 0);

    signal delta : unsigned (7 downto 0);

    signal imm_saida : unsigned (15 downto 0);
    signal opcode: unsigned (3 downto 0);
    signal R1, R2: unsigned (3 downto 0);
    signal func4: unsigned  (3 downto 0);
begin


    R1 <= instr_in(11 downto 8);
    R2 <= instr_in(7 downto 4);
    opcode <= instr_in(15 downto 12);
    func4 <= instr_in(3 downto 0);
    

    sel_acu <= "00" when opcode="0001" or opcode="0010" or opcode="1001" else --ADD e SUB e SUBI
               "01" when opcode="0011" and R1="1000" else --MOV
               "10" when opcode="0100" and R1="1000";   --LD
    

    sel_reg <= '0' when opcode="0100" and R1(3) = '0' else
    '1' when opcode="0011" and R1(3) = '0';
    
    wr_en_acu <= '1' when opcode="0001" or opcode="0010" or opcode="1001" or (opcode="0011" and R1="1000") or (opcode="0100" and R1="1000")  else
    '0';
    
    wr_en_reg <= '1' when (opcode="0100" and R1(3) = '0') or (opcode="0011"and R1(3) = '0' )else
    '0';
    
    wr_en_flags <= '0' when opcode="0011" or opcode="0100" else --MOV, LD e depois LW, SW
                    '1';
            
    wr_en_ram <= '1' when opcode="" else --LW,SW
                 '0';

    
                 

    ula_op <= "00" when opcode="0001" else --SOMA
    "01" when opcode="0010" or opcode="1001"; -- SUB,SUBI,
    
    sel_ula <= '1' when opcode="1001" else -- SUBI
               '0';
    
    instr_jump <= instr_in(11 downto 5); --Endereco absoluto 7bits [0,127]
    
    delta <= instr_in(11 downto 8) & instr_in(3 downto 0);-- Endereco relativo 8 bits [-127,127].
    
    relative_branch <= ('0' & current_addr) + delta; 

    imm_saida  <= "00000000" & instr_in(7 downto 0) when instr_in(7) = '0' else
                "11111111" & instr_in(7 downto 0) when instr_in(7) = '1' else
                "0000000000000000"; --extensao de sinal
    
    reg_dist <= R1(2 downto 0);
    
    reg_src <= R2 (2 downto 0);

    next_addr <= relative_branch(6 downto 0) when zero = '1' and opcode = "1000" else --BEQ
    relative_branch(6 downto 0) when (carry = '0' and zero ='0') and opcode = "0111" else --BLT
    instr_jump when opcode = "0101" else --JMP
    current_addr + 1 when state="10" else --NEXT
    current_addr; 

    imediato <= imm_saida;



end architecture;