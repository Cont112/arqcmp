library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seletor is 
		port ( sel      : in unsigned( 4 downto 0);
				 reg0		 : in unsigned( 15 downto 0);
				 reg1		 : in unsigned( 15 downto 0);
				 reg2		 : in unsigned( 15 downto 0);
				 reg3		 : in unsigned( 15 downto 0);
				 reg4		 : in unsigned( 15 downto 0);
				 reg5		 : in unsigned( 15 downto 0);
				 reg6		 : in unsigned( 15 downto 0);
				 reg7		 : in unsigned( 15 downto 0);	 
				 data_out : out unsigned(15 downto 0) 	
		);
end entity;
	
architecture a_seletor of seletor is
	begin
		data_out <=	 reg0 when sel="00000" else
						 reg1 when sel="00001" else
						 reg2 when sel="00010" else
						 reg3 when sel="00011" else
						 reg4 when sel="00100" else
						 reg5 when sel="00101" else
						 reg6 when sel="00110" else
						 reg7 when sel="00111" else
						 "0000000000000000";
end architecture;