library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.irig_b_pack.all;
entity oled_wrapper is
	port(
		CLK              : in std_logic;
		RST              : in std_logic;
		DATA_IN_TO_OLED : in data_to_oled_rec
	);
end entity oled_wrapper;

architecture RTL of oled_wrapper is

begin

end architecture RTL;
