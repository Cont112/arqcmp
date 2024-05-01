library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessor_tb is
end entity;

architecture a_microprocessor_tb of microprocessor_tb is

    component microprocessor is
        port(
            ula_op_sel : in unsigned (2 downto 0);
            ula_carry, ula_zero : out std_logic;
            ula_saida : out unsigned (15 downto 0);
            reg_a, reg_b, reg_write : in unsigned (2 downto 0);
            imediato: in unsigned(15 downto 0);
            im_sel: in std_logic;
            clk,rst,wr_en : in std_logic
        );
    end component;
    signal ula_op_sel, reg_a, reg_b, reg_write : unsigned(2 downto 0);
    signal ula_carry, ula_zero, im_sel, clk,rst,wr_en : std_logic;
    signal ula_saida, imediato : unsigned(15 downto 0);

    constant period_time : time := 100 ns;
    signal finished : std_logic;

    begin
        tb: microprocessor port map(
            ula_op_sel => ula_op_sel, reg_a => reg_a, reg_b => reg_b, reg_write=>reg_write, 
            ula_carry => ula_carry, ula_zero =>ula_zero, im_sel => im_sel, clk => clk,
            rst=>rst, wr_en => wr_en, ula_saida => ula_saida, imediato => imediato
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
            ula_op_sel <= "000"; -- SOMAR
            reg_write <= "001"; --NO REG 1
            reg_a <= "000"; -- O ZERO
            imediato <= "0000000000010101"; --IMEDIATO
            im_sel <= '1';
            wait for 200 ns;
          wait;
        end process;

end architecture;