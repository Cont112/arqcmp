library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bank8reg is
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
    signal data_in_0, data_out_0,
    data_in_1, data_out_1,
    data_in_2, data_out_2,
    data_in_3, data_out_3,
    data_in_4, data_out_4,
    data_in_5, data_out_5,
    data_in_6, data_out_6, 
    data_in_7, data_out_7 : unsigned(15 downto 0);
    
    begin
        reg0: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en,
            data_in=>data_in_0, data_out=>data_out_0
        );
        reg1: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en,
            data_in=>data_in_1, data_out=>data_out_1
        );
        reg2: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en,
            data_in=>data_in_2, data_out=>data_out_2
        );
        reg3: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en,
            data_in=>data_in_3, data_out=>data_out_3
        );
        reg4: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en,
            data_in=>data_in_4, data_out=>data_out_4
        );
        reg5: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en,
            data_in=>data_in_5, data_out=>data_out_5
        );
        reg6: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en,
            data_in=>data_in_6, data_out=>data_out_6
        );
        reg7: reg16bits port map(
            clk=>clk, rst=>rst, wr_en=>wr_en,
            data_in=>data_in_7, data_out=>data_out_7
        );
        
        read_data1 <=	data_out_1 when read_register1="00001" else
                        data_out_2 when read_register1="00010" else
                        data_out_3 when read_register1="00011" else
                        data_out_4 when read_register1="00100" else
                        data_out_5 when read_register1="00101" else
                        data_out_6 when read_register1="00110" else
                        data_out_7 when read_register1="00111" else
                        "0000000000000000";

        read_data2 <=	data_out_1 when read_register2="00001" else
                        data_out_2 when read_register2="00010" else
                        data_out_3 when read_register2="00011" else
                        data_out_4 when read_register2="00100" else
                        data_out_5 when read_register2="00101" else
                        data_out_6 when read_register2="00110" else
                        data_out_7 when read_register2="00111" else
                        "0000000000000000";

        process (clk, rst, wr_en)
        begin
            if wr_en='1' then
              if rising_edge(clk) then
                if (write_register = "00000") then -- NAO PODE ESCREVER AQUI DEPOIS MUDAR
                    data_in_0 <= write_data;
                elsif (write_register = "00001") then
                    data_in_1 <= write_data;
                elsif (write_register = "00010") then
                    data_in_2 <= write_data;
                elsif (write_register = "00011") then
                    data_in_3 <= write_data;
                elsif (write_register = "00100") then
                    data_in_4 <= write_data;
                elsif (write_register = "00101") then
                    data_in_5 <= write_data;
                elsif (write_register = "00110") then
                    data_in_6 <= write_data;
                elsif (write_register = "00111") then
                    data_in_7 <= write_data;
                end if;
              end if;
          end if;
        end process;        



end architecture;