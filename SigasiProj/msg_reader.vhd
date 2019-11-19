library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.irig_b_1pps_tb_pack.all;

entity msg_reader is
	port(
		CLK   : in  std_logic;
		RST   : in  std_logic;
		DATA  : out std_logic;
		VALID : out std_logic
	);
end entity msg_reader;

architecture RTL of msg_reader is
	file irig_file                 : text;
	constant c_num_of_words_in_msg : integer := 1000;
	signal s_counter               : integer;
begin
	read_proc : process(CLK, RST)
		variable v_line       : line;
		variable v_status     : boolean   := false;
		variable v_data       : std_logic := '0';
		variable v_file_close : boolean   := true;
	begin
		if (RST = c_init) then
			DATA      <= '0';
			VALID     <= '0';
			if (v_file_close) then
				file_open(irig_file, "irig_msg.txt", read_mode);
				v_file_close := false;
			end if;
			s_counter <= c_num_of_words_in_msg - 1;
		elsif (rising_edge(CLK)) then
			VALID     <= '0';
			s_counter <= s_counter - 1;
			if (s_counter = 0) then
				s_counter <= c_num_of_words_in_msg - 1;
			end if;

			if (s_counter = c_num_of_words_in_msg - 1) then
				if (not (endfile(irig_file))) then
					readline(irig_file, v_line);
				else
					file_close(irig_file);
				end if;
			end if;
			while (not (endfile(irig_file) or v_status)) loop
				read(v_line, v_data, v_status);
			end loop;
			if (v_status) then
				DATA  <= v_data;
				VALID <= '1';
			end if;
			v_status := false;

		end if;
	end process;

end architecture RTL;
