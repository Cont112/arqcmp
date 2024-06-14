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
    port(instr_in: in unsigned(15 downto 0); --Instrucao de 16 bits
        current_addr : in unsigned (6 downto 0); -- Endereco atual
        next_addr: out unsigned (6 downto 0); -- Proximo endereco
        state: in unsigned(1 downto 0);    --Estado atual

        sel_ula: out std_logic; --Selecao de entrada da ULA
        ula_op: out unsigned(1 downto 0);   -- Operacao ULA
        reg_src, reg_dist: out unsigned(2 downto 0);  --Registradores de origem e destino (os dois podem ser o acumulador)
        imediato: out unsigned(15 downto 0); -- Imediato extendido
        wr_en_reg, wr_en_acu: out std_logic;
        sel_reg: out std_logic;
        sel_acu: out unsigned(1 downto 0);
        zero, carry: in std_logic; --Flag zero e carry
        clk,rst : in std_logic --Clocks
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
    
    signal wr_en_acu, sel_reg,wr_en_reg: std_logic;
    signal ulaOP: unsigned (1 downto 0);
    signal sel_acu: unsigned(1 downto 0);
    signal zero, carry,negative: std_logic;
    signal current_addr, next_addr : unsigned(6 downto 0);
    signal instr_reg_in, instr_reg_out : unsigned(15 downto 0);
    signal state_out : unsigned(1 downto 0);
    signal reg_src, reg_dist : unsigned(2 downto 0);
    signal imediato, reg_data_in,reg_data_out, acu_in, acu_out, ula_saida, ula_entrada: unsigned(15 downto 0);
    signal clk_fetch, clk_execute, clk_decode, ula_sel: std_logic;

    
    begin

        maq: maq_estados port map(clk=>clk, rst=>rst, estado=>state_out);

        pc1: reg7bits port map(clk=>clk_execute, rst=>rst, wr_en=>'1', data_in=>next_addr, data_out=>current_addr);

        rom1: rom port map (clk=>clk_fetch, endereco=>current_addr, dado=>instr_reg_in);

        instr_reg1: reg16bits port map(clk=>clk_decode, rst=>rst, wr_en=>'1', data_in=>instr_reg_in, data_out=>instr_reg_out);

        uc1: un_controle port map (clk=>clk_execute, rst=>rst, instr_in=>instr_reg_out, current_addr=>current_addr, next_addr=>next_addr,
                                 state=>state_out,sel_ula=>ula_sel ,ula_op=>ulaOP, reg_src=>reg_src, reg_dist=>reg_dist, imediato=>imediato, 
                                 wr_en_reg=>wr_en_reg, wr_en_acu=>wr_en_acu, sel_reg=>sel_reg, sel_acu=>sel_acu, zero=>zero, carry=>carry);

        banco_registradores1: bank8reg port map(clk=>clk_execute, rst=>rst, wr_en=> wr_en_reg, read_register=>reg_src, write_register=>reg_dist,
                             write_data=>reg_data_in, read_data=>reg_data_out);

        acumulador1: reg16bits port map(clk=>clk_execute, rst=>rst, wr_en=>wr_en_acu, data_in=>acu_in, data_out=>acu_out);
        
        ula1: ula port map(A=>ula_entrada, B=>acu_out, ulaOP=>ulaOP, saida=>ula_saida, carry=>carry, negative=>negative, zero=>zero);

        acu_in <= ula_saida when sel_acu="00" else  --MUX ENTRADA DO ACUMULADOR
                  reg_data_out when sel_acu="01" else   --ESCOLHHA ENTRE IMEDIATO, REGISTRADOR E SAIDA DA ULA
                  imediato when sel_acu="10" else
                  "0000000000000000";

        reg_data_in <= imediato when sel_reg='0' else   --MUX ENTRADA DE DADOS DO BANCO 
                        acu_out when sel_reg='1' else --ESCOLHA ENTRE IMEDIATO E ACUMULADOR
                        "0000000000000000";           

        ula_entrada <= reg_data_out when ula_sel='0' else
                        imediato when ula_sel='1' else
                        "0000000000000000";
        clk_fetch <= '1' when state_out = "00" else '0';
        clk_decode <= '1' when state_out = "01" else '0';
        clk_execute <= '1' when state_out = "10" else '0';


        reg<=reg_data_out;
        acu<=acu_out;
        ula_out<=ula_saida;
        instr_pc<=current_addr;
        instr_reg<=instr_reg_out;
        estado_out<=state_out;
end architecture;