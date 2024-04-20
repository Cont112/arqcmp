library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity aritmetica is
    port(   x,y : in unsigned(15 downto 0);
            soma,subt, multi, xor_gate,and_gate,or_gate,nand_gate: out unsigned(15 downto 0);
            carry: out std_logic
    );
end entity;

architecture a_aritmetica of aritmetica is
signal multi32 : unsigned(31 downto 0);
signal x17, y17, soma17: unsigned(16 downto 0);
signal subtComp: unsigned(15 downto 0);
begin
    x17<= '0' & x;
    y17<= '0' & y;
    soma17<= x17 + y17;
    soma<= soma17(15 downto 0);
    carry<=soma17(16);

    subt<= x-y;

    multi32 <= x*y;
    multi <= multi32(15 downto 0);
    
    xor_gate<= x xor y;
    and_gate<= x and y;
    nand_gate<= x nand y;
    or_gate<= x or y;


end architecture;