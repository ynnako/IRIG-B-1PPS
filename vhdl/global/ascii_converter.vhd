library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

use work.irig_b_pack.all;

entity ascii_converter is
	port(
		DATA_IN         : in  std_logic_vector(c_ascii_conv_data_width - 1 downto 0);
		ASCII_VALUE_OUT : out std_logic_vector(c_ascii_conv_data_width - 1 downto 0)
	);
end entity ascii_converter;

architecture RTL of ascii_converter is

begin
	--@formatter:off
	ASCII_VALUE_OUT <= 	conv_std_logic_vector(c_zero_ascii_val 	   , c_ascii_conv_data_width) when DATA_IN = conv_std_logic_vector(0 , c_ascii_conv_data_width) else
						conv_std_logic_vector(c_zero_ascii_val + 1 , c_ascii_conv_data_width) when DATA_IN = conv_std_logic_vector(1 , c_ascii_conv_data_width) else 
						conv_std_logic_vector(c_zero_ascii_val + 2 , c_ascii_conv_data_width) when DATA_IN = conv_std_logic_vector(2 , c_ascii_conv_data_width) else
						conv_std_logic_vector(c_zero_ascii_val + 3 , c_ascii_conv_data_width) when DATA_IN = conv_std_logic_vector(3 , c_ascii_conv_data_width) else
						conv_std_logic_vector(c_zero_ascii_val + 4 , c_ascii_conv_data_width) when DATA_IN = conv_std_logic_vector(4 , c_ascii_conv_data_width) else
						conv_std_logic_vector(c_zero_ascii_val + 5 , c_ascii_conv_data_width) when DATA_IN = conv_std_logic_vector(5 , c_ascii_conv_data_width) else
						conv_std_logic_vector(c_zero_ascii_val + 6 , c_ascii_conv_data_width) when DATA_IN = conv_std_logic_vector(6 , c_ascii_conv_data_width) else
						conv_std_logic_vector(c_zero_ascii_val + 7 , c_ascii_conv_data_width) when DATA_IN = conv_std_logic_vector(7 , c_ascii_conv_data_width) else
						conv_std_logic_vector(c_zero_ascii_val + 8 , c_ascii_conv_data_width) when DATA_IN = conv_std_logic_vector(8 , c_ascii_conv_data_width) else
						conv_std_logic_vector(c_zero_ascii_val + 9 , c_ascii_conv_data_width) when DATA_IN = conv_std_logic_vector(9 , c_ascii_conv_data_width) else
						conv_std_logic_vector(c_error_ascii_val    , c_ascii_conv_data_width);
	--@formatter:on
end architecture RTL;
