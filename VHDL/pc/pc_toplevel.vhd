library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity  pc_toplevel is
    port(wr_en, clk : in std_logic;
        rst: in std_logic;
        instr : out unsigned (6 downto 0);
        data_out : out unsigned(31 downto 0)
    );

end entity;

architecture a_pc_toplevel of pc_toplevel is
component reg7bits is
    port( clk   : in std_logic;
    rst   : in std_logic;
    wr_en : in std_logic;
    data_in: in unsigned(6 downto 0);
    data_out: out unsigned(6 downto 0)
  );
end component;

component un_controle is
    port(data_in: in unsigned(31 downto 0);
         instr_in : in unsigned (6 downto 0);
         instr_out: out unsigned (6 downto 0);
         state: in std_logic
        );
end component;

component maq_estados is
    port( clk   : in std_logic;
    rst   : in std_logic;
    estado: out std_logic
  );
end component;

component rom is
    port( clk      : in std_logic;
    endereco : in unsigned(6 downto 0);
    dado     : out unsigned(31 downto 0) 
);
end component;

signal current_instr,next_instr: unsigned(6 downto 0);
signal current_data: unsigned (31 downto 0);
signal uc_op: std_logic;
begin
    mq: maq_estados port map (clk=>clk, rst=>rst, estado=>uc_op);
    uc: un_controle port map (data_in => current_data, instr_in => current_instr, instr_out => next_instr, state => uc_op);
    pc: reg7bits port map (clk=> clk, rst=>rst, wr_en=>wr_en, data_in => next_instr, data_out=>current_instr);
    rm: rom port map (clk=>clk, endereco=>current_instr, dado=>current_data);
    instr <= next_instr;
    data_out <= current_data;
end architecture;