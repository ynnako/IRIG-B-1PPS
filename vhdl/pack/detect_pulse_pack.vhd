library ieee;
use ieee.std_logic_1164.all;

package detect_pulse_pack is
	constant c_init                    : std_logic := '1';
	constant c_norm                    : std_logic := '0';
	constant c_data_rate               : integer   := 1; -- unit of KHz
	constant c_clk_rate                : integer   := 200000; -- unit of KHz
	constant c_ratio_between_clk       : integer   := c_clk_rate / c_data_rate;
	constant c_error_lim               : integer   := 0.05 * c_ratio_between_clk;
	constant c_zero_pulse_err_high_lim : integer   := 2 * c_ratio_between_clk + c_error_lim;
	constant c_zero_pulse_err_low_lim  : integer   := 2 * c_ratio_between_clk - c_error_lim;
	constant c_one_pulse_err_high_lim  : integer   := 5 * c_ratio_between_clk + c_error_lim;
	constant c_one_pulse_err_low_lim   : integer   := 5 * c_ratio_between_clk - c_error_lim;
	constant c_ref_pulse_err_high_lim  : integer   := 8 * c_ratio_between_clk + c_error_lim;
	constant c_ref_pulse_err_low_lim   : integer   := 8 * c_ratio_between_clk - c_error_lim;
	constant c_zero_pulse_data : std_logic_vector(2 downto 0) := "100";
	constant c_one_pulse_data  : std_logic_vector(2 downto 0) := "010";
	constant c_ref_pulse_data  : std_logic_vector(2 downto 0) := "001";

end package detect_pulse_pack;

package body detect_pulse_pack is

end package body detect_pulse_pack;
