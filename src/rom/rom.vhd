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
 
 --Carrega os numeros na RAM em sequencia
      0 => B"0100_001_000000000", -- LD R1,0;
      1 => B"0011_000_000000001", -- LD A,1;
      2 => B"0111_001_000000000", -- ADD A, R1;
      3 => B"0010_001_000000000", -- MOV R1, A;
      4 => B"1100_001_001_000000",-- SW R1, (R1);
      5 => B"0011_000_000100000", -- LD A, 32; 
      6 => B"1010_001_000000000", -- CMP R1, A;
      7 => B"0110_001_011111010", -- JPB 1, -6;
      
      --Escolhe o primeiro numero e verifica se é primo
      8 => B"0100_100_000000010", -- LD R4, 2;
      9 => B"1011_101_100_000000", -- LW R5, (R4)
      10 => B"0011_000_000000000",-- LD A, 0;
      11 => B"1010_101_000000000", -- CMP R5, A;
      12 => B"0110_000_000001010", -- JPB 0, 10; --Se nao for primo pula para o proximo numero
      13 => B"0001_101_000000000", -- MOV A, R5
      14 => B"0010_001_000000000", -- MOV R1, A
      
      --Se for primo elimina os multiplos
      15 => B"0001_101_000000000", -- MOV A, R5
      16 => B"0111_001_000000000", -- ADD A, R1;
      17 => B"0010_001_000000000", -- MOV R1, A;
      18 => B"1100_000_001_000000", -- SW R0, (R1);

      19 => B"0011_000_000100000", -- LD A, 32; 
      20 => B"1010_001_000000000", -- CMP R1, A;
      21 => B"0110_001_011111010", -- JPB 1, -6;
      
      --Vai ao proximo numero
      22 => B"0011_000_000000001", -- LD A, 1;
      23 => B"0111_100_000000000",-- ADD A, R4;
      24 => B"0010_100_000000000",-- MOV R4, A
      
      --Loopa enquanto o ctz de R4 for menor que 5 (<= 4)
      25 => B"1101_100_000000000",-- CTZ R4 (A <= ctz(R4)
      26 => B"0010_111_000000000", -- MOV R7,A
      27 => B"0011_000_000000101", -- LD A, 5
      28 => B"1010_111_000000000", -- CMP R7, A;
      29 => B"0110_011_011101100", -- JPB 3, -20

      --Itera a ram e coloca o resultado na saida da ula
      30=>B"0100_001_000000001", --LD R1, 1;
      31=>B"0011_000_000000001", --LD A, 1;
      32=>B"0111_001_000000000", --ADD A, R1;
      33=>B"0010_001_000000000", --MOV R1,A;
      34=>B"1011_011_001_000000", --LW R3, (R1);
      35=>B"0011_000_000100000", --LD A, 32;
      36=>B"1010_001_000000000", --CMP R1, A;
      37=>B"0110_001_011111010", --JPB 1, -6;
      

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

