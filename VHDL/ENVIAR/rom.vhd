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
      0 => B"0100_0011_00000000", -- Carrega R3 (o registrador 3) com o valor 0
      -- LD R3, 0
      1 => B"0100_0100_00000000", -- Carrega R4 com 0
      -- LD R4, 0

      2 => B"0011_1000_0011_0000", -- Soma R3 com R4 e guarda em R4 
      -- MOV A,R3 (A = R3)
      3 => B"0001_1000_0100_0000", --  Soma R3 com R4 e guarda em R4 
      -- ADD A,R4 (A = A + R4)
      4 => B"0011_0100_1000_0000", --  Soma R3 com R4 e guarda em R4 
      -- MOV R4,A (R4 = A)

      5 => B"0100_1000_00000001", -- Soma 1 em R3
      -- LD A,1
      6 => B"0001_1000_0011_0000", -- Soma 1 em R3
      -- ADD A,R3 (A = A + R3)
      7 => B"0011_0011_1000_0000", -- Soma 1 em R3
      -- MOV R3,A (R3 = A)

      8 => B"0100_1000_00011110", -- Se R3<30 salta para a instrução do passo C (INSTRUCAO 2) *SALTO RELATIVO*
      -- LD A,30
      9 => B"0111_1111_0011_1001", -- Se R3<30 salta para a instrução do passo C (INSTRUCAO 2) *SALTO RELATIVO*
      -- BLT R3,A,-7 (VOLTAR 7 INSTRUÇÕES)

      10 => B"0011_1000_0100_0000", -- Copia valor de R4 para R5
      -- MOV A,R4 (A = R4)
      11 => B"0011_0101_1000_0000", -- Copia valor de R4 para R5
      -- MOV R5,A (R5 = A)
      12 => B"0000_0000_0000_0000", -- NOP 
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

