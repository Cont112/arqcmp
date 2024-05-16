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
      0 => B"11000_011_000_00101", -- Carrega R3 (o registrador 3) com o valor 5
      -- addi x3, x0,5
      1 => B"11000_100_000_01000", -- Carrega R4 com 8
      -- addi x4,x0,8
      2 => B"01000_101_011_100_00", -- Soma R3 com R4 e guarda em R5
      -- add x5,x3,x4
      3 => B"11001_101_101_00001", -- Subtrai 1 de R5
      -- sub x5,x5,1
      4 => B"10000_0010100_0000", -- Salta para o endereço 20
      -- jump 20
      5 => B"01110_101_101_101_00", -- Zera R5 (nunca será executada)
      -- xor x5,x5
      20 => B"01000_011_000_101_00", -- No endereço 20, copia R5 para R3
      -- add x5,x0,x3
      21 => B"10000_0000011_0000", -- Salta para o passo C (3) desta lista (R5 <= R3+R4)
      -- jump 3
      22 => B"01110_011_011_011_00", -- Zera R3 (nunca será executada)
      --xor x3,x3

      -- abaixo: casos omissos => (zero em todos os bits)
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

