library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_toplevel_tb is 
end entity;

architecture a_pc_toplevel_tb of pc_toplevel_tb is
    component pc_toplevel is
        port(wr_en, clk : in std_logic;
        rst: in std_logic;
        instr : out unsigned (6 downto 0);
        data_out : out unsigned(31 downto 0)
    );
      end component;
          signal data_out : unsigned(31 downto 0);
          signal instr: unsigned (6 downto 0);
          signal clk,rst,wr_en : std_logic;
      
          constant period_time : time := 100 ns;
          signal finished : std_logic;
      
      begin
        uut: pc_toplevel port map(
          clk => clk, rst => rst, wr_en => wr_en, instr=>instr,
          data_out => data_out
        );
      
        reset_global: process
        begin
            rst <= '1';
            wait for period_time;-- eseperar 1 clocks
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
          wait for 100 ns;
          wr_en <= '1';
          wait;
        end process;
end architecture;