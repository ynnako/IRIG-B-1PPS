library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.irig_b_1pps_tb_pack.all;

entity msg_reader is
	port(
		CLK  : in  std_logic;
		RST  : in  std_logic;
		DATA : out std_logic
	);
end entity msg_reader;

architecture RTL of msg_reader is
	file irig_file                  : text;
	constant c_num_of_bits_in_frame : integer := 100;
	signal s_counter                : integer;
begin
	read_proc : process(CLK, RST)
		variable v_line        : line;
		variable v_status      : boolean   := false;
		variable v_data        : std_logic := '0';
		variable v_file_closed : boolean   := true;
	begin
		if (RST = c_init) then
			DATA      <= '0';
			if (v_file_closed) then
				file_open(irig_file, "./test_files/in_files/irig_msg.txt", read_mode);
				v_file_closed := false;
			end if;
			s_counter <= c_num_of_bits_in_frame - 1;
		elsif (rising_edge(CLK)) then
			s_counter <= s_counter - 1;
			if (s_counter = 0) then
				s_counter <= c_num_of_bits_in_frame - 1;
			end if;

			if (s_counter = c_num_of_bits_in_frame - 1) then
				if (not (v_file_closed or endfile(irig_file))) then
					readline(irig_file, v_line);
				elsif (not v_file_closed) then
					file_close(irig_file);
					v_file_closed := true;
				end if;
			end if;
			while (not (v_file_closed) and not (endfile(irig_file) or v_status)) loop
				read(v_line, v_data, v_status);
			end loop;
			if (v_status) then
				DATA <= v_data;
			end if;
			v_status := false;
			if (endfile(irig_file)) then
				file_close(irig_file);
				v_file_closed := true;
			end if;
		end if;
	end process;

end architecture RTL;
