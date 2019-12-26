library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sync is
	port(
		CLK : in std_logic;
		RESET : in std_logic;
		DATA_IN : in std_logic;
		DATA_OUT : out std_logic
	);
end entity sync;

architecture RTL of sync is
	-------------
	-- Constant
	-------------
	-------------
	-- Signals
	-------------
	signal data_in_sig : std_logic;
	signal data_in_reg : std_logic;
	signal data_sync_reg : std_logic;
	
begin
	data_in_sig  <= DATA_IN;
	DATA_OUT  <= data_sync_reg;
	
	sync_proc: process(CLK,RESET)
	begin
		if RESET = '1' then
			data_in_reg <= '0';
			data_sync_reg  <= '0';
		elsif rising_edge(CLK) then
			data_in_reg  <= data_in_sig;
			data_sync_reg  <= data_in_reg; 
		end if;
	end process;		

end architecture RTL;
