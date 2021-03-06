library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.irig_b_pack.all;

entity pps_gen is
	port(
		CLK                : in  std_logic;
		RST                : in  std_logic;
		IRIG_B_SYNCED_DATA : in  std_logic;
		REF_FLAG           : in  std_logic;
		SYNCED_TO_TIME     : out std_logic;
		PPS                : out std_logic
	);
end entity pps_gen;

architecture RTL of pps_gen is

	type pps_fsm is (sync_to_time_st, pps_gen_st);

	signal s_pps_gen_state      : pps_fsm;
	signal s_ref_to_ref_counter : integer;
	signal s_first_ref          : boolean;
	signal s_time_synced        : std_logic;

	signal s_pps           : std_logic;
	signal s_prev_data     : std_logic;
	signal s_ref_counter   : integer range -1 to c_num_refs_in_time_frame;
	signal s_sync_time_out : integer;
begin

	PPS            <= s_pps;
	SYNCED_TO_TIME <= s_time_synced;

	process(CLK, RST) is
	begin
		if (RST = c_init) then
			s_pps_gen_state      <= sync_to_time_st;
			s_ref_to_ref_counter <= 0;
			s_first_ref          <= true;
			s_ref_counter        <= 0;
			s_time_synced        <= '0';
			s_pps                <= '0';
			s_sync_time_out      <= 0;
		elsif (rising_edge(CLK)) then
			s_pps       <= '0';
			s_prev_data <= IRIG_B_SYNCED_DATA;
			case s_pps_gen_state is
				when sync_to_time_st =>
					if (not s_first_ref) then
						s_ref_to_ref_counter <= s_ref_to_ref_counter + 1;
					end if;
					if (REF_FLAG = '1') then
						if (s_first_ref) then
							s_first_ref <= false;
						elsif (s_ref_to_ref_counter > c_ten_ms - c_ten_ms_error and s_ref_to_ref_counter < c_ten_ms + c_ten_ms_error) then
							s_pps_gen_state <= pps_gen_st;
							s_ref_counter   <= 0;
							s_time_synced   <= '1';
						end if;
						s_ref_to_ref_counter <= 0;
					end if;

				when pps_gen_st =>
					s_sync_time_out <= s_sync_time_out + 1;
					if (s_sync_time_out >= (2 * c_half_frame_size) + c_frame_error) then
						s_first_ref     <= true;
						s_ref_counter   <= 0;
						s_pps_gen_state <= sync_to_time_st;
					end if;

					if (REF_FLAG = '1') then
						s_sync_time_out <= 0;
						s_ref_counter   <= s_ref_counter + 1;
					end if;
					if (s_ref_counter = c_num_refs_in_time_frame) then
						if (s_prev_data = '0' and IRIG_B_SYNCED_DATA = '1') then
							s_pps         <= '1';
							s_ref_counter <= -1;
						end if;
					end if;
			end case;
		end if;
	end process;


end architecture RTL;
