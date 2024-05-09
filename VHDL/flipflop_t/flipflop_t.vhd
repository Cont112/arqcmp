library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flipflop_t is
  port( clk   : in std_logic;
        rst   : in std_logic;
        wr_en : in std_logic;
        output: out std_logic
      );
end entity;

architecture a_flipflop_t of flipflop_t is
    signal saida : std_logic;
begin
  process (clk, rst, wr_en)
  begin
    if rst='1' then
        saida <= '0';
    elsif wr_en='1' then
        if rising_edge(clk) then
          saida <= not saida;
        end if;
    end if;
  end process;
  output <= saida;
end architecture;
