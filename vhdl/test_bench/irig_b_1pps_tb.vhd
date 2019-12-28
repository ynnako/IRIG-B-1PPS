library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.irig_b_1pps_tb_pack.all;
use work.irig_b_pack.all;

entity irig_b_1pps_tb is
end entity irig_b_1pps_tb;

architecture RTL of irig_b_1pps_tb is
	signal s_1pps_clk     : std_logic := '1';
	signal s_irig_clk     : std_logic := '1';
	signal s_rst          : std_logic := '1';
	signal s_irig_data_in : std_logic;
	signal s_one_pps      : std_logic;
	signal s_data_in      : std_logic;
	signal s_time_start   : integer;
	signal s_ref_falg     : std_logic;
	signal s_time_synced : std_logic;
	signal s_zero_pulse : std_logic;
	signal s_one_pulse : std_logic;
	signal s_ref_pulse : std_logic;
	signal sec_1_data_ascii_sig   : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal sec_10_data_ascii_sig  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal min_1_data_ascii_sig   : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal min_10_data_ascii_sig  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal hour_1_data_ascii_sig  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal hour_10_data_ascii_sig : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal day_1_data_ascii_sig   : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal day_10_data_ascii_sig  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal day_100_data_ascii_sig : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal year_1_data_ascii_sig  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal year_10_data_ascii_sig : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
begin

	s_rst <= '0' after 110 ns;

	rx_clk_gen_proc : process
		variable v_first_time : boolean := true;
	begin
		if(v_first_time)then
			wait for c_phase_rx_clk;
			v_first_time := false;
		end if;
		
		wait for c_rx_clk_half_period;
		s_1pps_clk <= not s_1pps_clk;

	end process rx_clk_gen_proc;

	irig_clk_gen_proc : process
		variable v_first_time : boolean := true;
	begin
		if(v_first_time)then
			wait for c_phase_irig_clk;
			v_first_time := false;
		end if;

		wait for c_irig_b_clk_half_period;
		s_irig_clk <= not s_irig_clk;

	end process irig_clk_gen_proc;

		

	u_file_reader : entity work.msg_reader
		port map(
			CLK  => s_irig_clk,
			RST  => s_rst,
			DATA => s_irig_data_in
		);
		
	u_irig_b_top : entity work.irig_b_top
		port map(
			MODULE_CLK         => s_1pps_clk,
			RESET              => s_rst,
			IRIG_B_DATA_IN     => s_irig_data_in,
			PPS                => s_one_pps,
			SEC_1_DATA_ASCII   => sec_1_data_ascii_sig,
			SEC_10_DATA_ASCII  => sec_10_data_ascii_sig,
			MIN_1_DATA_ASCII   => min_1_data_ascii_sig,
			MIN_10_DATA_ASCII  => min_10_data_ascii_sig,
			HOUR_1_DATA_ASCII  => hour_1_data_ascii_sig,
			HOUR_10_DATA_ASCII => hour_10_data_ascii_sig,
			DAY_1_DATA_ASCII   => day_1_data_ascii_sig,
			DAy_10_DATA_ASCII  => day_10_data_ascii_sig,
			DAY_100_DATA_ASCII => day_100_data_ascii_sig,
			YEAR_1_DATA_ASCII  => year_1_data_ascii_sig,
			YEAR_10_DATA_ASCII => year_10_data_ascii_sig
		);	
		
		
/* 
	u_sync_data : entity work.sync 
	port map(
		CLK  => s_1pps_clk,
		RESET  => s_rst,
		DATA_IN  => s_irig_data_in,
		DATA_OUT  => s_data_in
	);
	
	
	u_symbol_descrypter : entity work.symbol_decrypter
		port map(
			CLK                 => s_1pps_clk,
			RESET               => s_rst,
			DATA_IN             => s_data_in,
			DATA_OUT_ZERO_PULSE => s_zero_pulse,
			DATA_OUT_ONE_PULSE  => s_one_pulse,
			DATA_OUT_REF_PULSE  => s_ref_pulse
		);

	u_phase_lock : entity work.pps_gen
		port map(
			CLK                 => s_1pps_clk,
			RST                 => s_rst,
			SYNCED_DATA         => s_data_in,
			REF_FLAG            => s_ref_pulse,
			TIME_SYNCED 		=> s_time_synced,
			PPS					=> s_one_pps
		);
*/		

end architecture RTL;
