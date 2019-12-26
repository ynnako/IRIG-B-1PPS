library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.irig_b_pack.all;

entity pps_gen is
	port(
		CLK         : in  std_logic;
		RST         : in  std_logic;
		SYNCED_DATA : in  std_logic;
		REF_FLAG    : in  std_logic;
		TIME_SYNCED : out std_logic;
		PPS         : out std_logic
	);
end entity pps_gen;

architecture RTL of pps_gen is

	type pps_fsm is (sync_to_time_st, pps_gen_st);

	signal s_pps_gen_state      : pps_fsm;
	signal s_ref_to_ref_counter : integer;
	signal s_first_ref          : boolean;
	signal s_time_synced        : std_logic;

	signal s_pps         : std_logic;
	signal s_ref_counter : integer range 0 to c_num_refs_in_time_frame;
begin

	PPS         <= s_pps;
	TIME_SYNCED <= s_time_synced;

	process(CLK, RST) is
	begin
		if (RST = c_init) then
			s_pps_gen_state      <= sync_to_time_st;
			s_ref_to_ref_counter <= 0;
			s_first_ref          <= true;
			s_ref_counter        <= 0;
			s_time_synced        <= '0';
			s_pps                <= '0';
		elsif (rising_edge(CLK)) then
			s_time_synced <= '0';
			case s_pps_gen_state is
				when sync_to_time_st =>
					if (not s_first_ref) then
						s_ref_to_ref_counter <= s_ref_to_ref_counter + 1;
					end if;
					if (REF_FLAG = '1') then
						if (s_first_ref) then
							s_first_ref <= false;
						elsif (s_ref_to_ref_counter < c_half_frame_size) then
							s_pps_gen_state <= pps_gen_st;
							s_ref_counter   <= 1;
							s_time_synced   <= '1';
						end if;
						s_ref_to_ref_counter <= 0;
					end if;

				when pps_gen_st =>
					if (REF_FLAG = '1') then
						s_ref_counter <= s_ref_counter + 1;
					end if;
					if (s_ref_counter = c_num_refs_in_time_frame) then
						if (rising_edge(SYNCED_DATA)) then
							s_pps         <= '1';
							s_ref_counter <= 0;
						end if;
					end if;
			end case;
		end if;
	end process;


end architecture RTL;
