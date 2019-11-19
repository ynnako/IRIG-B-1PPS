library ieee;
use ieee.std_logic_1164.all;

package irig_b_pack is
	constant c_init : std_logic := '1';
	constant c_norm : std_logic := '0';

	constant c_first_rise  : std_logic := '0';
	constant c_second_rise : std_logic := '1';

	constant c_low_width  : integer := 4;
	constant c_high_width : integer := 10;
	constant c_ref_width  : integer := 16;
end package irig_b_pack;

package body irig_b_pack is

end package body irig_b_pack;
