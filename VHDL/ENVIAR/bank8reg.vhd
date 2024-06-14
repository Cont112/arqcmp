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

    component mux8x1 is
        port(   sel     : in unsigned(2 downto 0);
        entr0,entr1,entr2,entr3,
        entr4,entr5,entr6,entr7 : in unsigned(15 downto 0);
        saida   : out unsigned(15 downto 0)
      );
    end component;

    component demux1x8 is
        port( sel: in unsigned(2 downto 0);
        saida0,saida1,saida2,saida3,saida4,
        saida5,saida6,saida7: out std_logic
  );
    end component;
    signal wr_sel_0,wr_sel_1,wr_sel_2,wr_sel_3,
    wr_sel_4,wr_sel_5,wr_sel_6,wr_sel_7: std_logic;

    signal wr_en_0,wr_en_1,wr_en_2,wr_en_3,
           wr_en_4,wr_en_5,wr_en_6,wr_en_7: std_logic;

    signal data_out_0, data_out_1, data_out_2, data_out_3,
            data_out_4, data_out_5,data_out_6, data_out_7: unsigned(15 downto 0);

    signal saida1, saida2: unsigned (15 downto 0);
    
    begin
        mux1: mux8x1 port map(
            sel => read_register, entr0=>data_out_0, entr1=>data_out_1, entr2=>data_out_2, entr3=>data_out_3,
            entr4=>data_out_4, entr5=>data_out_5, entr6=>data_out_6, entr7=>data_out_7, saida=>read_data
        );
        
        demux1: demux1x8 port map(
            sel =>write_register , saida0 => wr_sel_0,saida1 => wr_sel_1, saida2 => wr_sel_2,saida3 => wr_sel_3,
            saida4 => wr_sel_4, saida5 => wr_sel_5, saida6 => wr_sel_6, saida7 => wr_sel_7);


        wr_en_0 <= wr_sel_0 and wr_en;
        wr_en_1 <= wr_sel_1 and wr_en;
        wr_en_2 <= wr_sel_2 and wr_en;
        wr_en_3 <= wr_sel_3 and wr_en;
        wr_en_4 <= wr_sel_4 and wr_en;
        wr_en_5 <= wr_sel_5 and wr_en;
        wr_en_6 <= wr_sel_6 and wr_en;
        wr_en_7 <= wr_sel_7 and wr_en;
    

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
