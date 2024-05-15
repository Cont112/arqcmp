library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end entity;

architecture a_processador_tb of processador_tb is

    component processador is
      port(
        ula_saida : out unsigned (15 downto 0);
        reg_data_1, reg_data_2 : out unsigned (15 downto 0); --falta acumulador
        instr_reg_out : out unsigned (15 downto 0); 
        instr_pc : out unsigned (15 downto 0);
        clk,rst : in std_logic
    );
    end component;

    signal ula_saida, reg_data_1,reg_data_2, instr_reg_out, instr_pc: unsigned (15 downto 0);

    signal clk,rst: std_logic;
    constant period_time : time := 100 ns;
    signal finished : std_logic;

    begin
        tb: processador port map( ula_saida => ula_saida, reg_data_1 =>reg_data_1, reg_data_2 => reg_data_2, instr_reg_out => instr_reg_out, instr_pc => instr_pc,
        clk=>clk, rst=>rst);
      
        reset_global: process
        begin
            rst <= '1';
            wait for period_time*2;-- eseperar 2 clocks
            rst <= '0';
            wait;
        end process;
      
        sim_time_proc: process
        begin
          wait for 2 us; -- TEMPO TOTAL DA SIMULACAO
          finished <= '1'; 
          wait;
        end process sim_time_proc;
        
        clk_proc: process
        begin
          while finished /= '1' loop
            clk<= '0';
            wait for period_time/2;
            clk<='1';
            wait for period_time/2;
          end loop;
          wait;
        end process clk_proc;
      
        process
        begin
            wait for 200 ns;
            wait;
        end process;

end architecture;