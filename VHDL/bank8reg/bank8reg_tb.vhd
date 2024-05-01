library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bank8reg_tb is 
end entity;



architecture a_bank8reg_tb of bank8reg_tb is
    component bank8reg is
        port(read_register1 : in unsigned(2 downto 0);
        read_register2 : in unsigned(2 downto 0);
        write_register : in unsigned(2 downto 0); -- SELECIONAR O REGISTRADOR SERA ESCRITO
        write_data     : in unsigned(15 downto 0);
        read_data1     : out unsigned(15 downto 0);
        read_data2     : out unsigned(15 downto 0);
        clk            : in std_logic;
        rst            : in std_logic;
        wr_en          : in std_logic
   );
    end component;
    signal read_data1, read_data2, write_data : unsigned(15 downto 0);
    signal read_register1, read_register2, write_register: unsigned(2 downto 0);
    signal clk,rst,wr_en : std_logic;

    constant period_time : time := 100 ns;
    signal finished : std_logic;

begin
  uut: bank8reg port map(
    read_register1 => read_register1, read_register2 => read_register2, write_data => write_data,
    read_data1 => read_data1, read_data2 => read_data2, write_register => write_register,
    clk => clk, rst => rst, wr_en => wr_en
  );

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
    wr_en <= '1';
    write_data <= "0000000000000100";
    write_register <= "001";
    wait for 200 ns;
    read_register1 <= "001";
    read_register2 <= "010";
    wait;
  end process;

end architecture a_bank8reg_tb;