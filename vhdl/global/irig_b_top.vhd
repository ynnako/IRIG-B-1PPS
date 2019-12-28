library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.irig_b_pack.all;

entity irig_b_top is
	port(
		MODULE_CLK         : in  std_logic;
		RESET              : in  std_logic;
		IRIG_B_DATA_IN     : in  std_logic;
		PPS				   : out std_logic;
		SEC_1_DATA_ASCII   : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		SEC_10_DATA_ASCII  : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		MIN_1_DATA_ASCII   : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		MIN_10_DATA_ASCII  : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		HOUR_1_DATA_ASCII  : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		HOUR_10_DATA_ASCII : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		DAY_1_DATA_ASCII   : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		DAy_10_DATA_ASCII  : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		DAY_100_DATA_ASCII : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		YEAR_1_DATA_ASCII  : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		YEAR_10_DATA_ASCII : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0)
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

	u_symbol_descrypter : entity work.symbol_decrypter
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
			SYNCED_DATA => irig_b_synced_data_sig,
			REF_FLAG    => ref_pulse_sig,
			TIME_SYNCED => time_synced_sig,
			PPS         => pps_sig
		);

	u_time_decryptor : entity work.time_decrypter
		port map(
			CLK                => MODULE_CLK,
			RESET              => RESET,
			DATA_IN_ZERO_PULSE => zero_pulse_sig,
			DATA_IN_ONE_PULSE  => one_pulse_sig,
			DATA_IN_REF_PULSE  => ref_pulse_sig,
			TIME_SYNCED        => time_synced_sig,
			PPS                => pps_sig,
			SEC_1_DATA_ASCII   => SEC_1_DATA_ASCII,
			SEC_10_DATA_ASCII  => SEC_10_DATA_ASCII,
			MIN_1_DATA_ASCII   => MIN_1_DATA_ASCII,
			MIN_10_DATA_ASCII  => MIN_10_DATA_ASCII,
			HOUR_1_DATA_ASCII  => HOUR_1_DATA_ASCII,
			HOUR_10_DATA_ASCII => HOUR_10_DATA_ASCII,
			DAY_1_DATA_ASCII   => DAY_1_DATA_ASCII,
			DAy_10_DATA_ASCII  => DAy_10_DATA_ASCII,
			DAY_100_DATA_ASCII => DAY_100_DATA_ASCII,
			YEAR_1_DATA_ASCII  => YEAR_1_DATA_ASCII,
			YEAR_10_DATA_ASCII => YEAR_10_DATA_ASCII
		);

end architecture RTL;