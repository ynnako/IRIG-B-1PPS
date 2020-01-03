library ieee;
use ieee.std_logic_1164.all;

package irig_b_pack is
	constant c_init                 : std_logic := '1';
	constant c_norm                 : std_logic := '0';
	constant c_data_rate            : integer   := 1; -- unit of KHz
	constant c_clk_rate             : integer   := 200; -- unit of KHz
	constant c_ratio_between_clk    : integer   := c_clk_rate / c_data_rate;
	constant c_precentage           : integer   := 20; -- 1/(%/100)
	constant c_error_lim            : integer   := c_ratio_between_clk / c_precentage;
	--
	constant c_zero_pulse_width     : integer   := 2;
	constant c_zero_one_width       : integer   := 5;
	constant c_zero_reference_width : integer   := 8;
	constant c_whole_symbol_width   : integer   := 10;

	constant c_num_of_symbols_in_frame : integer                      := 10;
	constant c_half_frame_size         : integer                      := c_whole_symbol_width * c_num_of_symbols_in_frame * c_clk_rate / 2;
	constant c_frame_error             : integer                      := 2 * c_half_frame_size / c_precentage;
	constant c_ten_ms                  : integer                      := 10 * c_clk_rate;
	constant c_ten_ms_error            : integer                      := c_ten_ms / c_precentage;
	constant c_num_refs_in_time_frame  : integer                      := 10;
	constant c_num_data_symbol_per_sec : integer                      := c_num_of_symbols_in_frame * c_num_refs_in_time_frame;
	--
	constant c_zero_pulse_err_high_lim : integer                      := c_zero_pulse_width * c_ratio_between_clk + c_error_lim;
	constant c_zero_pulse_err_low_lim  : integer                      := c_zero_pulse_width * c_ratio_between_clk - c_error_lim;
	constant c_one_pulse_err_high_lim  : integer                      := c_zero_one_width * c_ratio_between_clk + c_error_lim;
	constant c_one_pulse_err_low_lim   : integer                      := c_zero_one_width * c_ratio_between_clk - c_error_lim;
	constant c_ref_pulse_err_high_lim  : integer                      := c_zero_reference_width * c_ratio_between_clk + c_error_lim;
	constant c_ref_pulse_err_low_lim   : integer                      := c_zero_reference_width * c_ratio_between_clk - c_error_lim;
	constant c_max_count_val           : integer                      := c_ref_pulse_err_high_lim + 100;
	constant c_zero_pulse_data         : std_logic_vector(2 downto 0) := "100";
	constant c_one_pulse_data          : std_logic_vector(2 downto 0) := "010";
	constant c_ref_pulse_data          : std_logic_vector(2 downto 0) := "001";

	constant c_ascii_conv_data_width : integer := 8;
	constant c_zero_ascii_val        : integer := 48;
	constant c_error_ascii_val       : integer := 69;
	--
	constant c_num_of_digit_to_disp  : integer := 11;
	constant c_start_1_sec_index     : integer := 0;
	constant c_end_1_sec_index       : integer := 3;
	constant c_start_10_sec_index    : integer := 5;
	constant c_end_10_sec_index      : integer := 7;
	constant c_start_1_min_index     : integer := 9;
	constant c_end_1_min_index       : integer := 12;
	constant c_start_10_min_index    : integer := 14;
	constant c_end_10_min_index      : integer := 16;
	constant c_start_1_hour_index    : integer := 19;
	constant c_end_1_hour_index      : integer := 22;
	constant c_start_10_hour_index   : integer := 24;
	constant c_end_10_hour_index     : integer := 25;
	constant c_start_1_day_index     : integer := 29;
	constant c_end_1_day_index       : integer := 32;
	constant c_start_10_day_index    : integer := 34;
	constant c_end_10_day_index      : integer := 37;
	constant c_start_100_day_index   : integer := 39;
	constant c_end_100_day_index     : integer := 40;
	constant c_start_1_year_index    : integer := 49;
	constant c_end_1_year_index      : integer := 52;
	constant c_start_10_year_index   : integer := 54;
	constant c_end_10_year_index     : integer := 57;

	constant c_counted_unit_sec_index     : integer := 0;
	constant c_digit_of_dozens_sec_index  : integer := 1;
	constant c_counted_unit_min_index     : integer := 2;
	constant c_digit_of_dozens_min_index  : integer := 3;
	constant c_counted_unit_hour_index    : integer := 4;
	constant c_digit_of_dozens_hour_index : integer := 5;
	constant c_counted_unit_day_index     : integer := 6;
	constant c_digit_of_dozens_day_index  : integer := 7;
	constant c_counted_hundreds_day_index : integer := 8;
	constant c_counted_unit_year_index    : integer := 9;
	constant c_digit_of_dozens_year_index : integer := 10;

	type slv_array_type is array (integer range <>) of std_logic_vector;

	type data_to_oled_rec is record
		sec_1_data_ascii   : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		sec_10_data_ascii  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		min_1_data_ascii   : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		min_10_data_ascii  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		hour_1_data_ascii  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		hour_10_data_ascii : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		day_1_data_ascii   : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		day_10_data_ascii  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		day_100_data_ascii : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		year_1_data_ascii  : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		year_10_data_ascii : std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
	end record data_to_oled_rec;

end package irig_b_pack;

package body irig_b_pack is

end package body irig_b_pack;
