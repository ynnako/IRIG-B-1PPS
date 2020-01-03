library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.irig_b_pack.all;

entity irig_b_top is
	port(
		MODULE_CLK         : in  std_logic;
		RESET              : in  std_logic;
		IRIG_B_DATA_IN     : in  std_logic;
		PPS				   : out std_logic
	

	);
end entity irig_b_top;

architecture RTL of irig_b_top is

	signal irig_b_data_in_sig     : std_logic;
	signal irig_b_synced_data_sig : std_logic;
	signal zero_pulse_sig         : std_logic;
	signal one_pulse_sig          : std_logic;
	signal ref_pulse_sig          : std_logic;
	signal pps_sig                : std_logic;
	signal time_synced_sig        : std_logic;
	signal data_out_to_oled_sig       :data_to_oled_rec;


begin

	PPS  <= pps_sig;
	irig_b_data_in_sig  <= IRIG_B_DATA_IN;
	
	u_sync_data : entity work.sync
		port map(
			CLK      => MODULE_CLK,
			RESET    => RESET,
			DATA_IN  => irig_b_data_in_sig,
			DATA_OUT => irig_b_synced_data_sig
		);

	u_symbol_decoder : entity work.symbol_decoder
		port map(
			CLK                 => MODULE_CLK,
			RESET               => RESET,
			DATA_IN             => irig_b_synced_data_sig,
			DATA_OUT_ZERO_PULSE => zero_pulse_sig,
			DATA_OUT_ONE_PULSE  => one_pulse_sig,
			DATA_OUT_REF_PULSE  => ref_pulse_sig
		);

	u_pps_gen : entity work.pps_gen
		port map(
			CLK         => MODULE_CLK,
			RST         => RESET,
			IRIG_B_SYNCED_DATA => irig_b_synced_data_sig,
			REF_FLAG    => ref_pulse_sig,
			SYNCED_TO_TIME => time_synced_sig,
			PPS         => pps_sig
		);

	u_time_decoder : entity work.time_decoder
		port map(
			CLK                => MODULE_CLK,
			RESET              => RESET,
			DATA_IN_ZERO_PULSE => zero_pulse_sig,
			DATA_IN_ONE_PULSE  => one_pulse_sig,
			DATA_IN_REF_PULSE  => ref_pulse_sig,
			TIME_SYNCED        => time_synced_sig,
			PPS                => pps_sig,
			DATA_OUT_TO_OLED   => data_out_to_oled_sig 
		);
		
	u_oled_wrapper : entity work.oled_wrapper
		port map(
			CLK              => MODULE_CLK,
			RST              => RESET,
			DATA_IN_TO_OLED => data_out_to_oled_sig
		);	

end architecture RTL;
