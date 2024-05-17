library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
    port(
        ula_saida : out unsigned (15 downto 0);
        reg_data_1, reg_data_2 : out unsigned (15 downto 0); --falta acumulador
        instr_reg_out : out unsigned (15 downto 0);
        instr_pc : out unsigned (15 downto 0);
        state_out: out unsigned(1 downto 0);
        clk,rst : in std_logic
    );
end entity;

architecture a_processador of processador is
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

    component reg7bits is
        port( clk   : in std_logic;
            rst   : in std_logic;
            wr_en : in std_logic;
            data_in: in unsigned(6 downto 0);
            data_out: out unsigned(6 downto 0)
        );
    end component;

    component reg16bits is
        port( clk   : in std_logic;
            rst   : in std_logic;
            wr_en : in std_logic;
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;
    
    
    component un_controle is
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
    end component;
    
    component rom is
        port( clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(15 downto 0)
        );
    end component;

    signal  entr_ula_mux, saida_ula,
    data1, data2, imediato : unsigned(15 downto 0);

    signal current_instr,next_instr: unsigned(6 downto 0);

    signal PC_data, current_data: unsigned (15 downto 0);

    signal state: unsigned(1 downto 0);

    signal ula_op, reg1, reg2, reg_dist: unsigned (2 downto 0);

    signal wr_en_pc, wr_en_instr, wr_en_bank,wr_en_uc, im_sel,
    ula_carry, ula_zero : std_logic;

begin
    registradores: bank8reg port map (  read_register1 => reg1, read_register2 => reg2, write_register => reg_dist,
        write_data => saida_ula, clk => clk, rst=> rst, wr_en =>wr_en_bank,
        read_data1 => data1, read_data2 => data2
    );

    ula2: ula port map (A => data1, B => entr_ula_mux, ulaOP=> ula_op, carry => ula_carry, zero => ula_zero, saida => saida_ula);

    mux: mux1x2 port map(sel => im_sel, entr0 =>data2 , entr1=>imediato, saida => entr_ula_mux);

    uc: un_controle port map (data_in => current_data , instr_in => current_instr, instr_out=>next_instr,
        state => state, ula_op => ula_op, reg_a => reg1, reg_b=>reg2,
        reg_dist => reg_dist, imediato => imediato, wr_en => wr_en_uc, im_sel => im_sel, clk=>clk, rst=>rst);

    pc: reg7bits port map (clk=> clk, rst=>rst, wr_en=>wr_en_pc, data_in => next_instr, data_out=>current_instr);

    rm: rom port map (clk=>clk, endereco=>current_instr, dado=>Pc_data);

    ri: reg16bits port map (clk=>clk, rst=>rst, wr_en=>wr_en_instr, data_in => PC_data, data_out => current_data );

    wr_en_instr <= '1' when state = "00" else -- 
    '0';
    wr_en_pc <= '1' when state = "01" else --
    '0';
    wr_en_bank <= '1' when wr_en_uc = '1' and state = "10" else --
    '0';
    
    ula_saida <= saida_ula;
    instr_pc <= Pc_data;
    instr_reg_out <=current_data;
    reg_data_1 <= data1;
    reg_data_2 <= data2;
    state_out<= state;
end architecture;