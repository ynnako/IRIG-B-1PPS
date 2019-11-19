library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity irig_sync is
	port(
		CLK : in std_logic;
		RST : in std_logic;
		DATA_IN : in std_logic;
		ONE_PPS : out std_logic
	);
end entity irig_sync;

architecture RTL of irig_sync is
	type sync_pulse_fsm is (acquire_first_edge_st, count_first_symbol_st , count_second_symbol_st , acquire_second_edge_st, count_one_sec_st);
	signal s_fsm_state_reg : sync_pulse_fsm;
	signal s_data_in_meta : std_logic;
	signal s_data_in_synced : std_logic;
	signal s_prev_data_in_synced : std_logic;
	signal s_ref_length : integer;
	signal s_counter : integer;
begin

cdc_proc : process(CLK, RST) is
		
begin
	if(RST = '1')then
		s_data_in_meta <= '0';
		s_data_in_synced <= '0';
	elsif(rising_edge(CLK))then
		s_data_in_meta <= DATA_IN;
		s_data_in_synced <= s_data_in_meta;
	end if;
	end process cdc_proc;
	process(CLK, RST) is
		
	begin
		if (RST = '1') then
			s_fsm_state_reg <=  acquire_first_edge_st;
			s_counter <= 0;
			s_prev_data_in_synced <= '0';
			ONE_PPS <= '0';
		elsif (rising_edge(CLK)) then
			s_prev_data_in_synced  <= s_data_in_synced;
			ONE_PPS <= '0';
			case s_fsm_state_reg is
				when acquire_first_edge_st => 
					if(s_prev_data_in_synced = '0' and s_data_in_synced = '1')then
						s_fsm_state_reg <= count_first_symbol_st;
						s_counter <= s_counter + 1;
					end if;
				when count_first_symbol_st =>
					s_counter <= s_counter + 1;
					if(s_data_in_synced = '0'and s_counter <= 14)then
						s_fsm_state_reg <= acquire_first_edge_st;
						s_counter <= 0;
					end if;
					if(s_data_in_synced = '0' and s_counter > 14) then
						s_ref_length <= s_counter;
						s_counter <= 0;
						s_fsm_state_reg <= acquire_second_edge_st;
						end if;
						
				when acquire_second_edge_st =>
					if(s_prev_data_in_synced = '0' and s_data_in_synced = '1')then
						s_counter <= s_counter + 1;
						s_fsm_state_reg <= count_second_symbol_st;
					end if;
				when count_second_symbol_st => 
					s_counter <= s_counter + 1;
					if(s_data_in_synced = '0'and s_counter <= 14)then
						s_fsm_state_reg <= acquire_first_edge_st;
						s_counter <= 0;
					end if;
					if(s_data_in_synced = '0' and s_counter > 14) then
						s_counter <= s_counter + 1;
						s_fsm_state_reg <= count_one_sec_st;
						end if;
				when count_one_sec_st =>
					s_counter <= s_counter + 1;
					if(s_counter = 2000 - 1 )then
						ONE_PPS <= '1';
						s_counter <= 0;
					end if;
					
			end case;
		end if;
	end process;

end architecture RTL;
