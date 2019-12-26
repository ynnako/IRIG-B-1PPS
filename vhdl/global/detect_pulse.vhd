library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.detect_pulse_pack.all;
entity detect_pulse is
	generic(
		G_DATA_RATE : integer := 100    -- HZ unit
	);
	port(
		CLK      : in  std_logic;       -- 1 KHz clk
		RESET    : in  std_logic;
		DATA_IN  : in  std_logic;
		DATA_OUT : out std_logic_vector(2 downto 0) --DATA_OUT[0]-'0' ,DATA_OUT[1]-'1',DATA_OUT[2]-refrence
	);
end entity detect_pulse;

architecture RTL of detect_pulse is
	-------------
	-- Constant
	-------------

	-------------
	-- Signals
	-------------
	signal counter_detect_pulse : integer range 0 to 9;
	signal data_in_sig          : std_logic;
	signal data_out_reg         : std_logic_vector(2 downto 0);
	signal start_count          : std_logic;

begin
	data_in_sig <= DATA_IN;
	DATA_OUT    <= data_out_reg;

	detect_proc : process(CLK, RESET)
	begin
		if RESET = '1' then
			data_out_reg         <= (others => '0');
			start_count          <= '0';
			counter_detect_pulse <= 0;
		elsif rising_edge(CLK) then
			
			if rising_edge(data_in_sig) then -- detect rising edge in data
				start_count <= '1';
				
			elsif (start_count = '1' and data_in_sig = '1') then -- data is high anf in process of counting
				counter_detect_pulse <= counter_detect_pulse + 1;
			else
				start_count          <= '0';
				counter_detect_pulse <=  0 ;
				if ((counter_detect_pulse < c_zero_pulse_err_high_lim )and (counter_detect_pulse > c_zero_pulse_err_low_lim )) then
					data_out_reg <= c_zero_pulse_data;
				elsif ((counter_detect_pulse < c_one_pulse_err_high_lim )and (counter_detect_pulse > c_one_pulse_err_low_lim )) then
					data_out_reg <= c_one_pulse_data;
				elsif ((counter_detect_pulse < c_ref_pulse_err_high_lim )and (counter_detect_pulse > c_ref_pulse_err_low_lim )) then 
					data_out_reg <= c_ref_pulse_data;
				else
					data_out_reg <= (others => '0');
				end if;
			end if;
		end if;
	end process;

end architecture RTL;
