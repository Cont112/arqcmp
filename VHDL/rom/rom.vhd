library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rom is
   port( clk      : in std_logic;
         endereco : in unsigned(6 downto 0);
         dado     : out unsigned(31 downto 0) 
   );
end entity;
architecture a_rom of rom is
   type mem is array (0 to 127) of unsigned(31 downto 0);
   constant conteudo_rom : mem := (
      -- caso endereco => conteudcurrent_instr
      0 => "00000000111100000000000010011000", -- addi x1,x0,21 TIPO I  -- 0XF00098
      1 => "00000000100100000000000100011000", -- addi x2,x0,9  TIPO I  -- 0x900118
      2 => "00000000001000001000000110010000", -- add x3,x1,x2  TIPO R  -- 0x208190
      3 => "00001010001000001000000001100001", -- beq x1,x2, 5 --0xA208061
      4 => "00000000000100000000001000011000", -- add x4,x0,x1 TIPO 4  --0x100218
      5 => "00000000000000000000000000011000",  -- NOP ou addi x0,x0,0 --0x18
      6 => "00000000010000001000000001100001", -- beq x1,x4, 0  -- 0x408061
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