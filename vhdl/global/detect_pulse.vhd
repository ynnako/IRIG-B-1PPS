library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.detect_pulse_pack.all;
entity detect_pulse is

	port(
		CLK                 : in  std_logic; --  clk
		RESET               : in  std_logic;
		DATA_IN             : in  std_logic;
		DATA_OUT_ZERO_PULSE : out std_logic;
		DATA_OUT_ONE_PULSE  : out std_logic;
		DATA_OUT_REF_PULSE  : out std_logic
	);
end entity detect_pulse;

architecture RTL of detect_pulse is

	-------------
	-- Signals
	-------------
	signal counter_detect_pulse    : integer range 0 to c_max_count_val - 1;
	signal data_in_sig             : std_logic;
	signal data_out_zero_pulse_reg : std_logic;
	signal data_out_one_pulse_reg  : std_logic;
	signal data_out_ref_pulse_reg  : std_logic;
	signal start_count             : std_logic;

begin
	data_in_sig         <= DATA_IN;
	DATA_OUT_ZERO_PULSE <= data_out_zero_pulse_reg;
	DATA_OUT_ONE_PULSE  <= data_out_one_pulse_reg;
	DATA_OUT_REF_PULSE  <= data_out_ref_pulse_reg;

	detect_proc : process(CLK, RESET)
	begin
		if RESET = c_init then
			start_count             <= '0';
			counter_detect_pulse    <= 0;
			data_out_zero_pulse_reg <= '0';
			data_out_one_pulse_reg  <= '0';
			data_out_ref_pulse_reg  <= '0';
		elsif rising_edge(CLK) then

			if rising_edge(data_in_sig) then -- detect rising edge in data
				start_count <= '1';

			elsif (start_count = '1' and data_in_sig = '1') then -- data is high anf in process of counting
				counter_detect_pulse <= counter_detect_pulse + 1;
			else -- data is low
				start_count          <= '0';
				counter_detect_pulse <= 0;
				--  detect '0'
				if ((counter_detect_pulse < c_zero_pulse_err_high_lim) and (counter_detect_pulse > c_zero_pulse_err_low_lim)) then
					data_out_zero_pulse_reg <= '1';
					data_out_one_pulse_reg  <= '0';
					data_out_ref_pulse_reg  <= '0';
				--  detect '1'
				elsif ((counter_detect_pulse < c_one_pulse_err_high_lim) and (counter_detect_pulse > c_one_pulse_err_low_lim)) then
					data_out_zero_pulse_reg <= '0';
					data_out_one_pulse_reg  <= '1';
					data_out_ref_pulse_reg  <= '0';
				--  detect ref	
				elsif ((counter_detect_pulse < c_ref_pulse_err_high_lim) and (counter_detect_pulse > c_ref_pulse_err_low_lim)) then
					data_out_zero_pulse_reg <= '0';
					data_out_one_pulse_reg  <= '0';
					data_out_ref_pulse_reg  <= '1';
				-- steady state(data low and the result already updated)	
				else
					data_out_zero_pulse_reg <= '0';
					data_out_one_pulse_reg  <= '0';
					data_out_ref_pulse_reg  <= '0';
				end if;
			end if;
		end if;
	end process;

end architecture RTL;
