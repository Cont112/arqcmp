library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bank8reg_tb is 
end entity;



architecture a_bank8reg_tb of bank8reg_tb is
    component bank8reg is
        port(read_register1 : in unsigned(4 downto 0);
        read_register2 : in unsigned(4 downto 0);
        write_register : in unsigned(4 downto 0); -- SELECIONAR O REGISTRADOR SERA ESCRITO
        write_data     : in unsigned(15 downto 0);
        read_data1     : out unsigned(15 downto 0);
        read_data2     : out unsigned(15 downto 0);
        clk            : in std_logic;
        rst            : in std_logic;
        wr_en          : in std_logic
   );
    end component;

    
end architecture;