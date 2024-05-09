library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity maq_estados_tb is
end entity;


architecture a_maq_estados_tb of maq_estados_tb is 
component maq_estados is
    port( clk   : in std_logic;
    rst   : in std_logic;
    estado: out std_logic
  );
end component;
    signal estado: std_logic;
    signal clk,rst : std_logic;

    constant period_time : time := 100 ns;
    signal finished : std_logic;

begin
    uut: maq_estados port map(clk => clk, rst=> rst, estado=>estado);

  reset_global: process
  begin
      rst <= '1';
      wait for period_time*2;-- eseperar 2 clocks
      rst <= '0';
      wait;
  end process;

  sim_time_proc: process
  begin
    wait for 1 us; -- TEMPO TOTAL DA SIMULACAO
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
end architecture a_maq_estados_tb;
