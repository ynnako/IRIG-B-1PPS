library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

use work.irig_b_pack.all;

entity time_decoder is
	port(
		CLK                : in  std_logic;
		RESET              : in  std_logic;
		DATA_IN_ZERO_PULSE : in  std_logic;
		DATA_IN_ONE_PULSE  : in  std_logic;
		DATA_IN_REF_PULSE  : in  std_logic;
		TIME_SYNCED        : in  std_logic;
		PPS                : in  std_logic;
		DATA_OUT_TO_OLED   : out data_to_oled_rec
	);
end entity time_decoder;

architecture RTL of time_decoder is
	--------------
	-- Signals
	--------------
	signal data_in_zero_pulse_sig : std_logic;
	signal data_in_one_pulse_sig  : std_logic;
	signal data_in_ref_pulse_sig  : std_logic;
	signal time_synced_sig        : std_logic;
	signal pps_sig                : std_logic;
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

	signal symbol_data_reg        : std_logic_vector(c_num_data_symbol_per_sec - 1 downto 0)                              := (others => '0');
	signal data_to_convert_reg    : slv_array_type(0 to c_num_of_digit_to_disp - 1)(c_ascii_conv_data_width - 1 downto 0) := (others => (others => '0'));
	signal counter_ref_pulse_sig  : integer range -1 to c_num_refs_in_time_frame;
	signal counter_data_pulse_sig : integer range -1 to c_num_data_symbol_per_sec;
	signal update_time_sig        : std_logic;

begin

	data_in_zero_pulse_sig <= DATA_IN_ZERO_PULSE;
	data_in_one_pulse_sig  <= DATA_IN_ONE_PULSE;
	data_in_ref_pulse_sig  <= DATA_IN_REF_PULSE;
	time_synced_sig        <= TIME_SYNCED;
	pps_sig                <= PPS;
	DATA_OUT_TO_OLED.sec_1_data_ascii       <= sec_1_data_ascii_sig;
	DATA_OUT_TO_OLED.sec_10_data_ascii      <= sec_10_data_ascii_sig;
	DATA_OUT_TO_OLED.min_1_data_ascii       <= min_1_data_ascii_sig;
	DATA_OUT_TO_OLED.min_10_data_ascii      <= min_10_data_ascii_sig;
	DATA_OUT_TO_OLED.hour_1_data_ascii      <= hour_1_data_ascii_sig;
	DATA_OUT_TO_OLED.hour_10_data_ascii     <= hour_10_data_ascii_sig;
	DATA_OUT_TO_OLED.day_1_data_ascii       <= day_1_data_ascii_sig;
	DATA_OUT_TO_OLED.day_10_data_ascii      <= day_10_data_ascii_sig;
	DATA_OUT_TO_OLED.day_100_data_ascii     <= day_100_data_ascii_sig;
	DATA_OUT_TO_OLED.year_1_data_ascii      <= year_1_data_ascii_sig;
	DATA_OUT_TO_OLED.year_10_data_ascii     <= year_10_data_ascii_sig;
	
	
	

	process(CLK, RESET)
	begin
		if (RESET = c_init) then
			counter_ref_pulse_sig  <= 0;
			counter_data_pulse_sig <= 0;
			update_time_sig        <= '0';

		elsif rising_edge(CLK) then
			if (time_synced_sig = '1') then
				if (data_in_zero_pulse_sig = '1') then
					symbol_data_reg(counter_data_pulse_sig) <= '0';
					counter_data_pulse_sig                  <= counter_data_pulse_sig + 1;
				elsif (data_in_one_pulse_sig = '1') then
					symbol_data_reg(counter_data_pulse_sig) <= '1';
					counter_data_pulse_sig                  <= counter_data_pulse_sig + 1;
				elsif (data_in_ref_pulse_sig = '1') then
					counter_ref_pulse_sig  <= counter_ref_pulse_sig + 1;
					counter_data_pulse_sig <= counter_data_pulse_sig + 1;
				end if;
				if (counter_ref_pulse_sig = c_num_refs_in_time_frame) then
					counter_ref_pulse_sig  <= -1;
					counter_data_pulse_sig <= -1; 
				end if;

				if (pps_sig = '1') then
					update_time_sig <= '1';
				end if;

				if (update_time_sig = '1') then
					update_time_sig                                   <= '0';
					data_to_convert_reg(c_counted_unit_sec_index)     <= ext(symbol_data_reg(c_end_1_sec_index downto c_start_1_sec_index), c_ascii_conv_data_width);
					data_to_convert_reg(c_digit_of_dozens_sec_index)  <= ext(symbol_data_reg(c_end_10_sec_index downto c_start_10_sec_index), c_ascii_conv_data_width);
					data_to_convert_reg(c_counted_unit_min_index)     <= ext(symbol_data_reg(c_end_1_min_index downto c_start_1_min_index), c_ascii_conv_data_width);
					data_to_convert_reg(c_digit_of_dozens_min_index)  <= ext(symbol_data_reg(c_end_10_min_index downto c_start_10_min_index), c_ascii_conv_data_width);
					data_to_convert_reg(c_counted_unit_hour_index)    <= ext(symbol_data_reg(c_end_1_hour_index downto c_start_1_hour_index), c_ascii_conv_data_width);
					data_to_convert_reg(c_digit_of_dozens_hour_index) <= ext(symbol_data_reg(c_end_10_hour_index downto c_start_10_hour_index), c_ascii_conv_data_width);
					data_to_convert_reg(c_counted_unit_day_index)     <= ext(symbol_data_reg(c_end_1_day_index downto c_start_1_day_index), c_ascii_conv_data_width);
					data_to_convert_reg(c_digit_of_dozens_day_index)  <= ext(symbol_data_reg(c_end_10_day_index downto c_start_10_day_index), c_ascii_conv_data_width);
					data_to_convert_reg(c_counted_hundreds_day_index) <= ext(symbol_data_reg(c_end_100_day_index downto c_start_100_day_index), c_ascii_conv_data_width);
					data_to_convert_reg(c_counted_unit_year_index)    <= ext(symbol_data_reg(c_end_1_year_index downto c_start_1_year_index), c_ascii_conv_data_width);
					data_to_convert_reg(c_digit_of_dozens_year_index) <= ext(symbol_data_reg(c_end_10_year_index downto c_start_10_year_index), c_ascii_conv_data_width);

				end if;
			else
				update_time_sig <= '0';
				--TODO: need to add more signals
			end if;
		end if;
	end process;

-- synthesis translate_off
	u_reference_file_writer : entity work.file_writer
		port map(
			CLK          => CLK,
			RST          => RESET,
			SECONDS_ONES => data_to_convert_reg(c_counted_unit_sec_index),
			SECONDS_TENS => data_to_convert_reg(c_digit_of_dozens_sec_index),
			MINUTES_ONES => data_to_convert_reg(c_counted_unit_min_index),
			MINUTES_TENS => data_to_convert_reg(c_digit_of_dozens_min_index),
			HOURS_ONES   => data_to_convert_reg(c_counted_unit_hour_index),
			HOURS_TENS   => data_to_convert_reg(c_digit_of_dozens_hour_index),
			PPS          => PPS
		);
-- synthesis translate_on
	-----------------------------------------------------------------------------
	--------------------------------Seconds--------------------------------------
	-----------------------------------------------------------------------------
	u_convert_counted_unit_of_sec : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_counted_unit_sec_index),
			ASCII_VALUE_OUT => sec_1_data_ascii_sig
		);

	u_convert_digit_of_dozens_sec : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_digit_of_dozens_sec_index),
			ASCII_VALUE_OUT => sec_10_data_ascii_sig
		);
	-----------------------------------------------------------------------------
	--------------------------------Minutes--------------------------------------
	-----------------------------------------------------------------------------		
	u_convert_counted_unit_of_min : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_counted_unit_min_index),
			ASCII_VALUE_OUT => min_1_data_ascii_sig
		);

	u_convert_digit_of_dozens_min : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_digit_of_dozens_min_index),
			ASCII_VALUE_OUT => min_10_data_ascii_sig
		);
	-----------------------------------------------------------------------------
	----------------------------------Hours--------------------------------------
	-----------------------------------------------------------------------------		
	u_convert_counted_unit_of_hour : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_counted_unit_hour_index),
			ASCII_VALUE_OUT => hour_1_data_ascii_sig
		);

	u_convert_digit_of_dozens_hour : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_digit_of_dozens_hour_index),
			ASCII_VALUE_OUT => hour_10_data_ascii_sig
		);
	-----------------------------------------------------------------------------
	-----------------------------------Days--------------------------------------
	-----------------------------------------------------------------------------		

	u_convert_counted_unit_of_day : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_counted_unit_day_index),
			ASCII_VALUE_OUT => day_1_data_ascii_sig
		);

	u_convert_digit_of_dozens_day : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_digit_of_dozens_day_index),
			ASCII_VALUE_OUT => day_10_data_ascii_sig
		);

	u_convert_counted_hundrens_of_day : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_counted_hundreds_day_index),
			ASCII_VALUE_OUT => day_100_data_ascii_sig
		);
	-----------------------------------------------------------------------------
	------------------------------------Years------------------------------------
	-----------------------------------------------------------------------------		

	u_convert_counted_unit_of_year : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_counted_unit_year_index),
			ASCII_VALUE_OUT => year_1_data_ascii_sig
		);

	u_convert_digit_of_dozens_year : entity work.ascii_converter
		port map(
			DATA_IN         => data_to_convert_reg(c_digit_of_dozens_year_index),
			ASCII_VALUE_OUT => year_10_data_ascii_sig
		);

end architecture RTL;
