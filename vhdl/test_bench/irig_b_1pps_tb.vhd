library modelsim_lib;
use modelsim_lib.util.all;

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

	signal decoded_data : slv_array_type(0 to c_num_of_digit_to_disp - 1)(c_ascii_conv_data_width - 1 downto 0) := (others => (others => '0'));

begin

	init_signal_spy("/irig_b_1pps_tb/u_irig_b_top/u_time_decoder/data_to_convert_reg", "/decoded_data", 1);



	u_reference_file_writer : entity work.time_sniffer
		port map(
			CLK          => s_1pps_clk,
			RST          => s_rst,
			SECONDS_ONES => decoded_data(c_counted_unit_sec_index),
			SECONDS_TENS => decoded_data(c_digit_of_dozens_sec_index),
			MINUTES_ONES => decoded_data(c_counted_unit_min_index),
			MINUTES_TENS => decoded_data(c_digit_of_dozens_min_index),
			HOURS_ONES   => decoded_data(c_counted_unit_hour_index),
			HOURS_TENS   => decoded_data(c_digit_of_dozens_hour_index),
			PPS          => s_one_pps
		);


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
			IRIG_B_DATA => s_irig_data_in
		);


	u_irig_b_top : entity work.irig_b_top
		port map(
			MODULE_CLK     => s_1pps_clk,
			RESET          => s_rst,
			IRIG_B_DATA_IN => s_irig_data_in,
			PPS            => s_one_pps
		);	
		
	
end architecture RTL;
