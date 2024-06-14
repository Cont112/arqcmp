library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rom is
   port( clk      : in std_logic;
         endereco : in unsigned(6 downto 0);
         dado     : out unsigned(15 downto 0) 
   );
end entity;
architecture a_rom of rom is
   type mem is array (0 to 127) of unsigned(15 downto 0);
   constant conteudo_rom : mem := (

      -- caso endereco => conteudo   
      0 => B"0100_011_000011110", -- LD R3, 0X1E
      1 => B"0100_010_000000111", -- LD R2, 0X07
      2 => B"1100_010_011000000", -- SW R2, R3
      3 => B"1011_001_011000000", -- LW R1, R3
      others => (others=>'0')
   );
begin
   process(clk)
   begin
      if(rising_edge(clk)) then
         dado <= conteudo_rom(to_integer(endereco));
      end if;
   end process;
end architecture;

