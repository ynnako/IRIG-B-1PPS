library ieee;
use ieee.std_logic_1164.all;

package irig_b_1pps_tb_pack is

	constant c_rx_clk_half_period     : time := 2.5 ns;
	constant c_irig_b_clk_half_period : time := 0.5 us;
	constant c_phase_irig_clk         : time := 0.675 * c_irig_b_clk_half_period;
	constant c_phase_rx_clk           : time := 0.17 * c_rx_clk_half_period;

	constant c_init : std_logic := '1';
	constant c_norm : std_logic := '0';

end package irig_b_1pps_tb_pack;

package body irig_b_1pps_tb_pack is

end package body irig_b_1pps_tb_pack;
