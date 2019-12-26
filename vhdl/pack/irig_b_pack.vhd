library ieee;
use ieee.std_logic_1164.all;


package irig_b_pack is
	constant c_init                    : std_logic                    := '1';
	constant c_norm                    : std_logic                    := '0';
	constant c_data_rate               : integer                      := 1; -- unit of KHz
	constant c_clk_rate                : integer                      := 200; -- unit of KHz
	constant c_ratio_between_clk       : integer                      := c_clk_rate / c_data_rate;
	constant c_precentage			   : integer					  := 20; -- 1/(%/100)
	constant c_error_lim               : integer                      := c_ratio_between_clk / c_precentage;
	--
	constant c_zero_pulse_width        : integer                      := 2;
	constant c_zero_one_width          : integer                      := 5;
	constant c_zero_reference_width    : integer                      := 8;
	constant c_whole_symbol_width 	   : integer					  := 10;
	
	constant c_num_of_symbols_in_frame : integer					  := 10;
	constant c_half_frame_size 		   : integer					  := c_whole_symbol_width * c_num_of_symbols_in_frame * c_clk_rate / 2;
	constant c_num_refs_in_time_frame  : integer					  := 10;
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

	
end package irig_b_pack;

package body irig_b_pack is

end package body irig_b_pack;
