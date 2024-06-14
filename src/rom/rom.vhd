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
 
      0 => B"0100_001_000111111", --LD R1, 0x003F
      1 => B"0100_010_000010110",--LD R2, 0x0016
      2 => B"0100_011_000100111",--LD R3, 0x0027
      3 => B"0100_100_000000111",--LD R4, 0x0007
      4 => B"0100_101_000111101",--LD R5, 0x0039
      5 => B"0100_110_000000010",--LD R6, 0x0002
      6 => B"0000000000000000", --NOP
      7 => B"0100_111_000000101", --LD R7, 0x0001
      8 => B"0000000000000000", --NOP
      9 => B"1100_010_001_000000",-- SW R2, (R1)
      10 => B"1100_011_100_000000",-- SW R3, (R4)
      11 => B"0100_100_000001100", --LD R4, 0x00C
      12 => B"1100_001_100_000000", -- SW R1, (R4)
      13 => B"0100_100_000000010", -- LD R4, 0x0002
      14 => B"1100_101_100_000000", -- SW R5, (R4)
      15 => B"0100_100_000_001010", -- LD R4, 0x000A
      16 => B"1100_110_100_000000", -- SW R6, (R4)
      17 => B"0100_100_000_000011", -- LD R4, 0x0003
      18 => B"1100_111_100_000000", -- SW R7, (R4)
      19 => B"0000000000000000", --NOP
      20 => B"0100_001_000000000", --LD R1, 0 
      21 => B"0000000000000000", --NOP
      22 => B"0011_000_000000001", --LD A, 1
      23 => B"0111_101_000000000", --ADD A, R5
      24 => B"0010_101_000000000", --MOV R5,A
      25 => B"1011_001_101_000000",--LW R1, R5 
      26 => B"0000000000000000", --NOP
      27 => B"1100_100_100_000000",-- SW R4, (R4)
      28 => B"0100_110_000001010", -- LD R6, A
      29 => B"1011_010_110_000000",--LW R2, (6)
      30 => B"0100_011_111111110", --LD R3, FFE
      31 => B"1100_011_110_000000", -- SW R3, (R6)



 
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

