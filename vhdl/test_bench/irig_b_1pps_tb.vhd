library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.irig_b_1pps_tb_pack.all;
use work.irig_b_pack.all;

entity irig_b_1pps_tb is
end entity irig_b_1pps_tb;

architecture RTL of irig_b_1pps_tb is
	signal s_1pps_clk     : std_logic := '1';
	signal s_irig_clk     : std_logic := '1';
	signal s_rst          : std_logic := '1';
	signal s_irig_data_in : std_logic := '0';
	signal s_one_pps      : std_logic := '0';


begin

	s_rst <= '0' after 110 ns;

	rx_clk_gen_proc : process
		variable v_first_time : boolean := true;
	begin
		if(v_first_time)then
			wait for c_phase_rx_clk;
			v_first_time := false;
		end if;
		
		wait for c_rx_clk_half_period;
		s_1pps_clk <= not s_1pps_clk;

	end process rx_clk_gen_proc;

	irig_clk_gen_proc : process
		variable v_first_time : boolean := true;
	begin
		if(v_first_time)then
			wait for c_phase_irig_clk;
			v_first_time := false;
		end if;

		wait for c_irig_b_clk_half_period;
		s_irig_clk <= not s_irig_clk;

	end process irig_clk_gen_proc;

		

	u_file_reader : entity work.msg_reader
		port map(
			CLK  => s_irig_clk,
			RST  => s_rst,
			DATA => s_irig_data_in
		);
		
	u_irig_b_top : entity work.irig_b_top
		port map(
			MODULE_CLK         => s_1pps_clk,
			RESET              => s_rst,
			IRIG_B_DATA_IN     => s_irig_data_in,
			PPS                => s_one_pps
			   
		);	
		

end architecture RTL;
