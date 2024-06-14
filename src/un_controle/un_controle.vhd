library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity  un_controle is
    port(instruction: in unsigned(15 downto 0); --Instrucao a ser executada
        current_addr: in unsigned(6 downto 0); --Endereco atual
        next_addr: out unsigned(6 downto 0); --Proximo endereco

        fetch_clk, decode_clk, execute_clk, memory_clk: out std_logic; --Sinais de controle
        wr_en_ram, wr_en_flags, wr_en_reg, wr_en_acu: out std_logic; --Sinais de controle

        ula_op: out unsigned(1 downto 0); --Operacao da ULA
        ula_sel: out std_logic; --Selecao entrada da ULA (imediato ou registrador)

        acu_sel: out unsigned(1 downto 0); --Selecao entrada do acumulador

        reg_wr: out unsigned(2 downto 0); --Registrador a ser escrito
        reg_read1, reg_read2: out unsigned(2 downto 0); --Registradores a serem lidos
        reg_data_sel: out unsigned(1 downto 0); --Selecao dado a ser escrito no registrador (saida do acumulador, ram, imediato)

        imediato: out unsigned(15 downto 0); --Imediato extendido

        ram_addr: out unsigned(6 downto 0);

        zero, carry, negative: in std_logic; --Flags

        clk, rst : in std_logic
    );
end entity;

architecture a_un_controle of un_controle is

    component maq_estados is
        port(clk,rst: in std_logic;
            estado: out unsigned(1 downto 0)
        );     
    end component;
    
    signal jmp_en, br_en: std_logic;
    signal estado: unsigned(1 downto 0);
    signal condition: unsigned(2 downto 0);
    signal opcode: unsigned(3 downto 0);
    signal instr_jump: unsigned(6 downto 0);
    signal relative_addr: unsigned(7 downto 0);
    signal imm: unsigned(8 downto 0);

begin
    maq: maq_estados port map(clk,rst,estado);

    fetch_clk <= '1' when estado="00" else '0';
    decode_clk <= '1' when estado="01" else '0';
    memory_clk <= '1' when estado="10" else '0';
    execute_clk <= '1' when estado="11" else '0';

    opcode <= instruction(15 downto 12);
    imm <= instruction(8 downto 0);
    instr_jump <= instruction(6 downto 0);

    reg_read1 <= instruction(11 downto 9);
    reg_read2 <= instruction(8 downto 6);

    condition <= instruction(11 downto 9) when opcode="0110" else --JPB
        "000";

    reg_wr <= instruction(11 downto 9) when opcode="0010" else --MOV
        instruction(11 downto 9) when opcode="0100" else --LD
        instruction(11 downto 9) when opcode="1011" else --LW
        instruction(11 downto 9) when opcode="1101" else --LU
        "000"; --(SUBB)

    relative_addr <= ('0' & current_addr) + imm(7 downto 0); --Endereco relativo
    imediato <= "0000000" & imm when imm(8)='0' else "11111111" & imm when imm(8)='1'; --Extensao de sinal
    
    ram_addr <= instruction(6 downto 0);
    --controle de escrita na memoria
    wr_en_ram <= '1' when opcode="1100" else --SW
        '0';   
    
    --controle de escritas nos latches de flag
    wr_en_flags <= '1' when opcode="0111" else --ADD
        '1' when opcode="1000" else --SUB
        '1' when opcode="1001" else --SUBI
        '1' when opcode="1010" else --CMP
        '0'; --(SUBB)

    --controle de escrita no banco de registradores
    wr_en_reg <= '1' when opcode="0010" else--MOV
        '1' when opcode="0100" else --LD
        '1' when opcode="1100" else --LW
        '1' when opcode="1101" else --Lu
        '0';

    --controle de escrita no acumulador
    wr_en_acu <= '1' when opcode="0111" else --ADD
        '1' when opcode="1000" else --SUB
        '1' when opcode="0001" else --MOV
        '1' when opcode="0011" else --LD
        '1' when opcode="1001" else --SUBI
        '0'; --(SUBB)

    --operacao da ula
    ula_op <= "00" when opcode="0111" else --ADD
        "01" when opcode="1000" else --SUB
        "01" when opcode="1001" else --SUBI
        "01" when opcode="1010" else --CMP
        "00"; --(SUBB)

    --mux de entrada da ula
    ula_sel <= '1' when opcode="1001" else --SUBI
        '0';

    --mux de entrada do acumulador
    acu_sel <= "00" when opcode="0111" else --ADD
        "00" when opcode="1000" else --SUB
        "00" when opcode="1001" else --SUBI (SUBB)
        "01" when opcode="0001" else --MOV
        "10" when opcode="0011" else --LD
        "00";

    reg_data_sel <= "01" when opcode="0100" else --LD
        "10" when opcode="1011" else --LW
        "10" when opcode="1100" else --LU
        "00";

    jmp_en <= '1' when opcode="0101" else --JMP
        '0';
    
    br_en <= '1' when opcode="0110" and condition="000" and zero='1' else --BEQ
        '1' when opcode="0110" and condition="001" and (negative='1') else --BLT
        '1' when opcode="0110" and condition="010" and negative='1' else --BGT
        '1' when opcode="0110" and condition="011" and zero='0' else --BNE
        '0'; --JPB

    next_addr <= relative_addr(6 downto 0) when br_en='1' else --JPB
        instr_jump when jmp_en='1' else --JMP
        current_addr + 1; --NEXT


end architecture;