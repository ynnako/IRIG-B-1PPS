library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.irig_b_pack.all;

entity pps_gen is
	port(
		CLK         : in  std_logic;
		RST         : in  std_logic;
		SYNCED_DATA : in  std_logic;
		REF_FLAG    : in  std_logic;
		PPS         : out std_logic
	);
end entity pps_gen;

architecture RTL of pps_gen is

	signal s_pps         : std_logic;
	signal s_ref_counter : integer range 0 to 15;
begin
	
	PPS <= s_pps;
	cdc_proc : process(CLK, RST) is
		
	begin
		if (RST = c_init) then
			s_ref_counter <= 0;
		elsif (rising_edge(CLK)) then
			s_pps <= '0';
			if (REF_FLAG = '1') then
				s_ref_counter <= s_ref_counter + 1;
			end if;
			if (s_ref_counter = c_frame_size) then
				if (rising_edge(SYNCED_DATA)) then
					s_pps         <= '1';
					s_ref_counter <= 0;
				end if;
			end if;
			
				
		end if;
	end process cdc_proc;
	

end architecture RTL;
