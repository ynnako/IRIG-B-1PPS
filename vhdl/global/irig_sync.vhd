library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.irig_b_pack.all;

entity irig_sync is
	port(
		CLK                 : in  std_logic;
		RST                 : in  std_logic;
		DATA_IN             : in  std_logic;
		SYNCED_DATA         : out std_logic;
		TIME_SINCE_LAST_REF : out integer;
		REF_FLAG            : out std_logic
	);
end entity irig_sync;

architecture RTL of irig_sync is

	type sync_pulse_fsm is (acquire_edge_st, count_first_symbol_st, count_second_symbol_st);

	signal s_fsm_state_reg             : sync_pulse_fsm;
	signal s_data_in_meta              : std_logic;
	signal s_data_in_synced            : std_logic;
	signal s_prev_data_in_synced       : std_logic;
	signal s_ref_flag                  : std_logic;
	signal s_first_or_second_rise_flag : std_logic;
	signal s_time_since_ref            : integer;
	signal s_counter                   : integer;
begin
	SYNCED_DATA         <= s_data_in_synced;
	TIME_SINCE_LAST_REF <= s_time_since_ref;
	REF_FLAG            <= s_ref_flag;
	cdc_proc : process(CLK, RST) is
	begin
		if (RST = c_init) then
			s_data_in_meta   <= '0';
			s_data_in_synced <= '0';
		elsif (rising_edge(CLK)) then
			s_data_in_meta   <= DATA_IN;
			s_data_in_synced <= s_data_in_meta;
		end if;
	end process cdc_proc;
	fsm_prc : process(CLK, RST) is
	begin
		if (RST = c_init) then
			s_counter                   <= 0;
			s_fsm_state_reg             <= acquire_edge_st;
			s_ref_flag                  <= '0';
			s_time_since_ref            <= 0;
			s_prev_data_in_synced       <= '1';
			s_first_or_second_rise_flag <= c_first_rise;
		elsif (rising_edge(CLK)) then
			s_prev_data_in_synced <= s_data_in_synced;
			s_ref_flag            <= '0';
			case s_fsm_state_reg is

				when acquire_edge_st =>
					if (s_prev_data_in_synced = '0' and s_data_in_synced = '1') then
						s_counter <= s_counter + 1;
						if (s_first_or_second_rise_flag = c_first_rise) then
							s_fsm_state_reg <= count_first_symbol_st;
						elsif (s_first_or_second_rise_flag = c_second_rise) then
							s_fsm_state_reg <= count_second_symbol_st;
						end if;
					end if;

				when count_first_symbol_st =>
					s_counter <= s_counter + 1;
					if (s_data_in_synced = '0') then
						if (s_counter <= c_high_width + (c_ref_width - c_high_width) / 2) then
							s_first_or_second_rise_flag <= c_first_rise;
						elsif (s_counter > c_high_width + (c_ref_width - c_high_width) / 2) then
							s_first_or_second_rise_flag <= c_second_rise;
						end if;
						s_counter       <= 0;
						s_fsm_state_reg <= acquire_edge_st;
					end if;
				when count_second_symbol_st =>
					s_counter <= s_counter + 1;
					if (s_data_in_synced = '0') then
						if (s_counter > c_high_width + (c_ref_width - c_high_width) / 2) then
							s_time_since_ref <= s_counter + 1;
							s_ref_flag       <= '1';
						end if;
						s_fsm_state_reg             <= acquire_edge_st;
						s_counter                   <= 0;
						s_first_or_second_rise_flag <= c_first_rise;
					end if;
			end case;
		end if;
	end process fsm_prc;

end architecture RTL;
