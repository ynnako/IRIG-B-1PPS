library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.irig_b_1pps_tb_pack.all;
use work.irig_b_pack.all;

entity file_writer is
	port(
		CLK          : in std_logic;
		RST          : in std_logic;
		SECONDS_ONES : in std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		SECONDS_TENS : in std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		MINUTES_ONES : in std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		MINUTES_TENS : in std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		HOURS_ONES   : in std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		HOURS_TENS   : in std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		PPS          : in std_logic;
		
	);
end entity file_writer;

architecture RTL of file_writer is
begin

	write_proc : process(CLK, RST)
		file out_file   : text open write_mode is "./test_files/out_files/irig_msg_out.txt";
		variable v_line : line;
	begin
		if (RST = c_init) then
		elsif (rising_edge(CLK)) then
			if (PPS = '1') then
				write(v_line, conv_integer(unsigned(HOURS_TENS)));
				write(v_line, conv_integer(unsigned(HOURS_ONES)));
				swrite(v_line, ":");
				write(v_line, conv_integer(unsigned(MINUTES_TENS)));
				write(v_line, conv_integer(unsigned(MINUTES_ONES)));
				swrite(v_line, ":");
				write(v_line, conv_integer(unsigned(SECONDS_TENS)));
				write(v_line, conv_integer(unsigned(SECONDS_ONES)));
				writeline(out_file, v_line);
			end if;
		end if;

	end process write_proc;
		
	

end architecture RTL;
