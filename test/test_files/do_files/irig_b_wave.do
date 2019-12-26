onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /irig_b_1pps_tb/rx_clk_gen_proc/v_first_time
add wave -noupdate /irig_b_1pps_tb/irig_clk_gen_proc/v_first_time
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_sync_data/CLK
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_sync_data/RESET
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_sync_data/DATA_IN
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_sync_data/DATA_OUT
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_sync_data/data_in_sig
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_sync_data/data_in_reg
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_sync_data/data_sync_reg
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/CLK
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/RESET
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/DATA_IN
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/DATA_OUT_ZERO_PULSE
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/DATA_OUT_ONE_PULSE
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/DATA_OUT_REF_PULSE
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/counter_symbol_decrypter
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/data_in_sig
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/data_out_zero_pulse_reg
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/data_out_one_pulse_reg
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/data_out_ref_pulse_reg
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_symbol_descrypter/start_count
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/CLK
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/RST
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/SYNCED_DATA
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/REF_FLAG
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/TIME_SYNCED
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/PPS
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/s_pps_gen_state
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/s_ref_to_ref_counter
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/s_first_ref
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/s_time_synced
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/s_pps
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/s_ref_counter
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_phase_lock/s_sync_time_out
add wave -noupdate -group u_file_reader /irig_b_1pps_tb/u_file_reader/CLK
add wave -noupdate -group u_file_reader /irig_b_1pps_tb/u_file_reader/RST
add wave -noupdate -group u_file_reader /irig_b_1pps_tb/u_file_reader/DATA
add wave -noupdate -group u_file_reader /irig_b_1pps_tb/u_file_reader/s_counter
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_1pps_clk
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_irig_clk
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_rst
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_irig_data_in
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_one_pps
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_data_in
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_time_start
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_ref_falg
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_time_synced
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_zero_pulse
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_one_pulse
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/s_ref_pulse
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
