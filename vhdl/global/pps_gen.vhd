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

	signal s_ref_to_ref_counter : integer;
	signal s_sync_en            : std_logic;
	signal s_pps_gen_en         : std_logic;
	signal s_time_synced        : std_logic;

	signal s_pps         : std_logic;
	signal s_ref_counter : integer range 0 to 15;
begin

	PPS         <= s_pps;
	TIME_SYNCED <= s_time_synced;
	frame_sync_proc : process(CLK, RST) is
	begin
		if (RST = c_init) then
			s_ref_to_ref_counter <= 0;
			s_sync_en            <= '0';
			s_pps_gen_en         <= '0';
		elsif (rising_edge(CLK)) then
			s_time_synced <= '0';
			if (s_pps_gen_en = '0') then -- enable process if we are allready synced to time frame

				s_ref_to_ref_counter <= s_ref_to_ref_counter + 1;
				if (REF_FLAG = '1' and s_sync_en = '0') then
					s_sync_en            <= '1';
					s_ref_to_ref_counter <= 0;
				elsif (REF_FLAG = '1' and s_sync_en = '1') then
					if (s_ref_to_ref_counter > c_half_frame_size) then
						s_ref_to_ref_counter <= 0;
					else                -- we have found two near references
						s_pps_gen_en  <= '1';
						s_time_synced <= '1';
					end if;
				end if;

			end if;
		end if;

	end process frame_sync_proc;	
	
		
	pps_gen_proc : process(CLK, RST) is
	begin
		if (RST = c_init) then
			s_ref_counter <= 0;
		elsif (rising_edge(CLK)) then
			s_pps <= '0';
			if (s_pps_gen_en = '1') then

				if (REF_FLAG = '1') then
					s_ref_counter <= s_ref_counter + 1;
				end if;
				if (s_ref_counter = c_num_refs_in_time_frame) then
					if (rising_edge(SYNCED_DATA)) then
						s_pps         <= '1';
						s_ref_counter <= 0;
					end if;
				end if;

			end if;
		end if;
	end process pps_gen_proc;
	

end architecture RTL;
