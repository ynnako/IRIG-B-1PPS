library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.irig_b_1pps_tb_pack.all;
use work.irig_b_pack.all;

entity irig_b_1pps_tb is
end entity irig_b_1pps_tb;

architecture RTL of irig_b_1pps_tb is
	signal s_1pps_clk             : std_logic := '1';
	signal s_irig_clk             : std_logic := '1';
	signal s_rst                  : std_logic := '1';
	signal s_irig_data_in         : std_logic;
	signal s_one_pps              : std_logic;
	signal s_data_in              : std_logic;
	signal s_time_start           : integer;
	signal s_ref_falg             : std_logic;
	signal s_time_synced          : std_logic;
	signal s_zero_pulse           : std_logic;
	signal s_one_pulse            : std_logic;
	signal s_ref_pulse            : std_logic;
	signal data_out_to_oled_sig   : data_to_oled_rec;
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

	signal sec_1_data_sig   : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal sec_10_data_sig  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal min_1_data_sig   : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal min_10_data_sig  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal hour_1_data_sig  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	signal hour_10_data_sig : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
begin

	s_rst <= '0' after 110 ns;

	rx_clk_gen_proc : process
		variable v_first_time : boolean := true;
	begin
		if (v_first_time) then
			wait for c_phase_rx_clk;
			v_first_time := false;
		end if;

		wait for c_rx_clk_half_period;
		s_1pps_clk <= not s_1pps_clk;

	end process rx_clk_gen_proc;

	irig_clk_gen_proc : process
		variable v_first_time : boolean := true;
	begin
		if (v_first_time) then
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

	sec_1_data_sig   <= <<signal .irig_b_1pps_tb.u_irig_b_top.u_time_decryptor.u_convert_counted_unit_of_sec.DATA_IN  : std_logic_vector >>;
	sec_10_data_sig  <= <<signal .irig_b_1pps_tb.u_irig_b_top.u_time_decryptor.u_convert_digit_of_dozens_sec.DATA_IN  : std_logic_vector >>;
	min_1_data_sig   <= <<signal .irig_b_1pps_tb.u_irig_b_top.u_time_decryptor.u_convert_counted_unit_of_min.DATA_IN  : std_logic_vector >>;
	min_10_data_sig  <= <<signal .irig_b_1pps_tb.u_irig_b_top.u_time_decryptor.u_convert_digit_of_dozens_min.DATA_IN  : std_logic_vector >>;
	hour_1_data_sig  <= <<signal .irig_b_1pps_tb.u_irig_b_top.u_time_decryptor.u_convert_counted_unit_of_hour.DATA_IN  : std_logic_vector >>;
	hour_10_data_sig <= <<signal .irig_b_1pps_tb.u_irig_b_top.u_time_decryptor.u_convert_digit_of_dozens_hour.DATA_IN  : std_logic_vector >>;

	u_file_writer : entity work.file_writer
		port map(
			CLK          => s_1pps_clk,
			RST          => s_rst,
			SECONDS_ONES => sec_1_data_sig,
			SECONDS_TENS => sec_10_data_sig,
			MINUTES_ONES => min_1_data_sig,
			MINUTES_TENS => min_1_data_sig,
			HOURS_ONES   => hour_1_data_sig,
			HOURS_TENS   => hour_10_data_sig,
			PPS          => s_one_pps
		);

	u_irig_b_top : entity work.irig_b_top
		port map(
			MODULE_CLK       => s_1pps_clk,
			RESET            => s_rst,
			IRIG_B_DATA_IN   => s_irig_data_in,
			PPS              => s_one_pps,
			DATA_OUT_TO_OLED => data_out_to_oled_sig
		);	
		
	
end architecture RTL;
