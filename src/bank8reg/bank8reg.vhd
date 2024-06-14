library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bank8reg is
    port(read_register : in unsigned(2 downto 0);
         write_register : in unsigned(2 downto 0);
         write_data     : in unsigned(15 downto 0);
         read_data     : out unsigned(15 downto 0);
         clk            : in std_logic;
         rst            : in std_logic;
         wr_en          : in std_logic
    );
end entity;

architecture a_bank8reg of bank8reg is 
    component reg16bits is
        port( 
        clk     : in std_logic;
        rst     : in std_logic;
        wr_en   : in std_logic;
        data_in : in unsigned(15 downto 0);
        data_out: out unsigned(15 downto 0)
      );
    end component;

    signal wr_en_1,wr_en_2,wr_en_3,
           wr_en_4,wr_en_5,wr_en_6,wr_en_7: std_logic;

    signal data_out_0, data_out_1, data_out_2, data_out_3,
            data_out_4, data_out_5,data_out_6, data_out_7: unsigned(15 downto 0);

    signal saida1, saida2: unsigned (15 downto 0);
    
    begin

        read_data <= data_out_0 when read_register = "000" else
                     data_out_1 when read_register = "001" else
                     data_out_2 when read_register = "010" else
                     data_out_3 when read_register = "011" else
                     data_out_4 when read_register = "100" else
                     data_out_5 when read_register = "101" else
                     data_out_6 when read_register = "110" else
                     data_out_7 when read_register = "111" else
                     "0000000000000000";
        
        wr_en_1 <= '1' when write_register="001" and wr_en='1' else
            '0';
        wr_en_2 <= '1' when write_register="010" and wr_en='1' else
            '0';
        wr_en_3 <= '1' when write_register="011" and wr_en='1' else
            '0';
        wr_en_4 <= '1' when write_register="100" and wr_en='1' else
            '0';
        wr_en_5 <= '1' when write_register="101" and wr_en='1' else
            '0';
        wr_en_6 <= '1' when write_register="110" and wr_en='1' else
            '0';
        wr_en_7 <= '1' when write_register="111" and wr_en='1' else
            '0';
    

        reg0: reg16bits port map(
            clk=>'0', rst=>'1', wr_en=>'0',data_in=>"0000000000000000", data_out=>data_out_0);
        reg1: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en_1,data_in=>write_data, data_out=>data_out_1);
        reg2: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en_2,data_in=>write_data, data_out=>data_out_2);
        reg3: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en_3,data_in=>write_data, data_out=>data_out_3);
        reg4: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en_4,data_in=>write_data, data_out=>data_out_4);
        reg5: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en_5,data_in=>write_data, data_out=>data_out_5);
        reg6: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en_6,data_in=>write_data, data_out=>data_out_6);
        reg7: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en_7,data_in=>write_data, data_out=>data_out_7);
        

end architecture;
