library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end entity;

architecture a_processador_tb of processador_tb is

    component processador is
      port(
        ula_out : out unsigned (15 downto 0); --Saida da Ula
        reg : out unsigned (15 downto 0); --Dado lido do banco de registrador
        acu : out unsigned (15 downto 0); --Dado lido do acumulador
        instr_reg: out unsigned (15 downto 0); --Insutrucao lida do registrador de instrucao
        instr_pc : out unsigned (6 downto 0);  -- Instrucao no PC
        estado_out: out unsigned(1 downto 0);    -- Estado atual
        clk,rst : in std_logic  --Clocks
    );
    end component;

    signal ula_out, reg,acu,instr_reg: unsigned (15 downto 0);
    signal instr_pc: unsigned (6 downto 0);
    signal estado_out:unsigned (1 downto 0);

    signal clk, rst: std_logic := '0';
    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';

    begin
        tb: processador port map( ula_out, reg, acu, instr_reg, instr_pc, estado_out, clk, rst);
      
        sim_time_proc: process
        begin
          wait for 100 us;
          finished <= '1';
          wait;
        end process;
      
        clk_proc: process
        begin
          while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
          end loop;
          wait;
        end process;
      
        rst_proc: process
        begin
          rst<='1';
          wait for period_time;
          rst<='0';
          wait;
        end process;
      end architecture;