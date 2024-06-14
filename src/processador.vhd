library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
    port(
        ula_out : out unsigned (15 downto 0); --Saida da Ula
        reg : out unsigned (15 downto 0); --Dado lido do banco de registrador
        acu : out unsigned (15 downto 0); --Dado lido do acumulador
        instr_reg: out unsigned (15 downto 0); --Insutrucao lida do registrador de instrucao
        instr_pc : out unsigned (6 downto 0);  -- Instrucao no PC
        estado_out: out unsigned(1 downto 0);    -- Estado atual
        clk,rst : in std_logic  --Clocks
    );
end entity;

architecture a_processador of processador is
    component bank8reg is
        port(read_register : in unsigned(2 downto 0);
            write_register : in unsigned(2 downto 0);
            write_data     : in unsigned(15 downto 0);
            read_data      : out unsigned(15 downto 0);
            clk            : in std_logic;
            rst            : in std_logic;
            wr_en          : in std_logic
        );
    end component;

    component ula is
        port(   A, B : in unsigned(15 downto 0); --Entrada da ula onde B sempre é o acumulador.
        ulaOP    : in unsigned(1 downto 0);
        saida    : out unsigned(15 downto 0);
        carry    : out std_logic;
        negative : out std_logic;
        zero     : out std_logic
    );
    end component;

    component reg1bit is -- REG PARA AS FLAGS
        port( clk   : in std_logic;
        rst   : in std_logic;
        wr_en : in std_logic;
        data_in: in std_logic;
        data_out: out std_logic
      );
    end component;
    component reg7bits is --PC
        port( clk   : in std_logic;
            rst   : in std_logic;
            wr_en : in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
        );
    end component;

    component reg16bits is --REGISTRADOR DE INSTRUCAO
        port( clk   : in std_logic;
            rst   : in std_logic;
            wr_en : in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;
    
    
    component un_controle is 
    port(instruction: in unsigned(15 downto 0); --Instrucao a ser executada
        current_addr: in unsigned(6 downto 0); --Endereco atual
        next_addr: out unsigned(6 downto 0); --Proximo endereco

        fetch_clk, decode_clk, execute_clk, memory_clk: out std_logic; --Sinais de controle
        wr_en_ram, wr_en_raddr, wr_en_flags, wr_en_reg, wr_en_acu: out std_logic; --Sinais de controle

        ula_op: out unsigned(1 downto 0); --Operacao da ULA
        ula_sel, ram_sel: out std_logic; --Selecao entrada da ULA (imediato ou registrador)

        acu_sel: out unsigned(1 downto 0); --Selecao entrada do acumulador

        reg_wr: out unsigned(2 downto 0); --Registrador a ser escrito
        reg_read1, reg_read2: out unsigned(2 downto 0); --Registradores a serem lidos
        reg_data_sel: out unsigned(1 downto 0); --Selecao dado a ser escrito no registrador (saida do acumulador, ram, imediato)

        imediato: out unsigned(15 downto 0); --Imediato extendido

        zero, carry, negative: in std_logic; --Flags

        clk, rst : in std_logic
    );
    end component;
    
    component rom is
        port( clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(15 downto 0)
        );
    end component;

    component maq_estados is
        port( clk,rst: in std_logic;
            estado: out unsigned(1 downto 0)
        );
    end component;
    
    component ram is
        port( 
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            wr_en    : in std_logic;
            dado_in  : in unsigned(15 downto 0);
            dado_out : out unsigned(15 downto 0) 
      );
    end component;

    --Unidade de Controle
    signal fetch_clk, decode_clk, execute_clk, memory_clk : std_logic;
    signal wr_en_ram, wr_en_flags, wr_en_reg, wr_en_acu, wr_en_raddr: std_logic;
    signal ula_sel: std_logic;
    signal reg_data_sel, ula_op, acu_sel : unsigned(1 downto 0);
    signal reg_wr : unsigned(2 downto 0);
    signal reg_read1, reg_read2 : unsigned(2 downto 0);
    signal imediato : unsigned(15 downto 0);
    --Pc
    signal pc_in, current_addr : unsigned(6 downto 0);

    --Flags
    signal zero_flag, carry_flag, negative_flag : std_logic;

    --Rom
    signal rom_data, instruction : unsigned(15 downto 0);

    --Ram
    signal ram_data : unsigned(15 downto 0);
    signal ram_addr: unsigned(15 downto 0 );
    signal ram_sel : std_logic;
    --Banco de Registradores
    signal data_in, data_out : unsigned(15 downto 0);
    signal read_reg : unsigned(2 downto 0);

    --Acumulador
    signal acu_in, acu_out: unsigned(15 downto 0);

    --ULA
    signal ula_carry, ula_zero, ula_negative: std_logic;
    signal ula_saida, ula_entrada: unsigned(15 downto 0);
    
    begin
        --Unidade de Controle
        uc: un_controle port map (clk => clk, rst => rst, instruction => instruction, current_addr => current_addr,
            next_addr => pc_in, fetch_clk => fetch_clk, decode_clk => decode_clk, execute_clk => execute_clk, memory_clk =>memory_clk,
            wr_en_ram => wr_en_ram, wr_en_flags => wr_en_flags, wr_en_reg => wr_en_reg, wr_en_acu => wr_en_acu, wr_en_raddr => wr_en_raddr,
            ula_op => ula_op, ula_sel => ula_sel, acu_sel => acu_sel, reg_wr => reg_wr, reg_read1 => reg_read1, reg_read2 => reg_read2, ram_sel => ram_sel,
            reg_data_sel => reg_data_sel, imediato => imediato, zero =>zero_flag, carry => carry_flag, negative => negative_flag);

        --Flags
        zero : reg1bit port map (clk => execute_clk, rst => rst, wr_en => wr_en_flags, data_in => ula_zero, data_out => zero_flag);
        carry : reg1bit port map (clk => execute_clk, rst => rst, wr_en => wr_en_flags, data_in => ula_carry, data_out => carry_flag);
        negative : reg1bit port map (clk => execute_clk, rst => rst, wr_en => wr_en_flags, data_in => ula_negative, data_out => negative_flag);

        --Rom e Registrador de Instrucoes
        rom1: rom port map (clk => fetch_clk, endereco => current_addr, dado => rom_data);
        ir: reg16bits port map (clk => decode_clk, rst => rst, wr_en => '1', data_in => rom_data, data_out => instruction);

        --Pc
        pc: reg7bits port map (clk => execute_clk, rst => rst, wr_en => '1', data_in => pc_in, data_out => current_addr);

        --Ram
        raddr: reg16bits port map (clk => memory_clk,rst => rst, wr_en => wr_en_raddr, data_in => data_out , data_out => ram_addr);
        ram1: ram port map (clk => execute_clk, wr_en=>wr_en_ram, endereco => ram_addr(6 downto 0), dado_in => data_out, dado_out => ram_data);

        --Banco de Registradores
        data_in <= acu_out when reg_data_sel = "00" else
            imediato when reg_data_sel = "01" else
            ram_data when reg_data_sel = "10" else
            "0000000000000000"; 
        
        read_reg <= reg_read2 when ram_sel='1' else 
        reg_read1;
        bank: bank8reg port map (read_register => read_reg, write_register => reg_wr, write_data => data_in,
        read_data => data_out, clk => execute_clk, rst => rst, wr_en => wr_en_reg);

        --Acumulador
        acu_in <= ula_saida when acu_sel = "00" else
            data_out when acu_sel = "01" else
            imediato when acu_sel = "10" else
            "0000000000000000";
        acu1: reg16bits port map (clk => execute_clk, rst => rst, wr_en => wr_en_acu, data_in => acu_in, data_out => acu_out);

        --ULA
        ula_entrada <= data_out when ula_sel = '0' else
            imediato when ula_sel='1';

        ula1: ula port map (A => ula_entrada , B => acu_out, ulaOP => ula_op, saida => ula_saida, carry => ula_carry, negative => ula_negative, zero => ula_zero);

        reg<=data_out;
        acu<=acu_out;
        ula_out<=ula_saida;
        instr_pc<=current_addr;
        instr_reg<=instruction;

end architecture;