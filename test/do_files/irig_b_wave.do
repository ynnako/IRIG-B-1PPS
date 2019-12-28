onerror {resume}
quietly WaveActivateNextPane {} 0
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
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/sec_1_data_ascii_sig
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/sec_10_data_ascii_sig
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/min_1_data_ascii_sig
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/min_10_data_ascii_sig
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/hour_1_data_ascii_sig
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/hour_10_data_ascii_sig
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/day_1_data_ascii_sig
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/day_10_data_ascii_sig
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/day_100_data_ascii_sig
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/year_1_data_ascii_sig
add wave -noupdate -group irig_b_1pps_tb /irig_b_1pps_tb/year_10_data_ascii_sig
add wave -noupdate -group u_file_reader /irig_b_1pps_tb/u_file_reader/CLK
add wave -noupdate -group u_file_reader /irig_b_1pps_tb/u_file_reader/RST
add wave -noupdate -group u_file_reader /irig_b_1pps_tb/u_file_reader/DATA
add wave -noupdate -group u_file_reader /irig_b_1pps_tb/u_file_reader/s_counter
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/MODULE_CLK
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/RESET
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/IRIG_B_DATA_IN
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/PPS
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/SEC_1_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/SEC_10_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/MIN_1_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/MIN_10_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/HOUR_1_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/HOUR_10_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/DAY_1_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/DAy_10_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/DAY_100_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/YEAR_1_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/YEAR_10_DATA_ASCII
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/irig_b_data_in_sig
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/irig_b_synced_data_sig
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/zero_pulse_sig
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/one_pulse_sig
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/ref_pulse_sig
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/pps_sig
add wave -noupdate -group u_irig_b_top /irig_b_1pps_tb/u_irig_b_top/time_synced_sig
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_irig_b_top/u_sync_data/CLK
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_irig_b_top/u_sync_data/RESET
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_irig_b_top/u_sync_data/DATA_IN
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_irig_b_top/u_sync_data/DATA_OUT
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_irig_b_top/u_sync_data/data_in_sig
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_irig_b_top/u_sync_data/data_in_reg
add wave -noupdate -group u_sync_data /irig_b_1pps_tb/u_irig_b_top/u_sync_data/data_sync_reg
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/CLK
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/RESET
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/DATA_IN
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/DATA_OUT_ZERO_PULSE
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/DATA_OUT_ONE_PULSE
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/DATA_OUT_REF_PULSE
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/counter_symbol_decrypter
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/data_in_sig
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/data_out_zero_pulse_reg
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/data_out_one_pulse_reg
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/data_out_ref_pulse_reg
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/start_count
add wave -noupdate -group u_symbol_descrypter /irig_b_1pps_tb/u_irig_b_top/u_symbol_descrypter/data_in_reg
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/CLK
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/RST
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/SYNCED_DATA
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/REF_FLAG
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/TIME_SYNCED
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/PPS
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/s_pps_gen_state
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/s_ref_to_ref_counter
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/s_first_ref
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/s_time_synced
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/s_pps
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/s_prev_data
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/s_ref_counter
add wave -noupdate -group u_pps_gen /irig_b_1pps_tb/u_irig_b_top/u_pps_gen/s_sync_time_out
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/CLK
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/RESET
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/DATA_IN_ZERO_PULSE
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/DATA_IN_ONE_PULSE
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/DATA_IN_REF_PULSE
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/TIME_SYNCED
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/PPS
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/SEC_1_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/SEC_10_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/MIN_1_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/MIN_10_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/HOUR_1_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/HOUR_10_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/DAY_1_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/DAy_10_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/DAY_100_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/YEAR_1_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/YEAR_10_DATA_ASCII
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/data_in_zero_pulse_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/data_in_one_pulse_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/data_in_ref_pulse_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/time_synced_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/pps_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/sec_1_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/sec_10_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/min_1_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/min_10_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/hour_1_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/hour_10_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/day_1_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/day_10_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/day_100_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/year_1_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/year_10_data_ascii_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/symbol_data_reg
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/data_to_convert_reg
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/counter_ref_pulse_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/counter_data_pulse_sig
add wave -noupdate -group u_time_dectypter /irig_b_1pps_tb/u_irig_b_top/u_time_decryptor/update_time_sig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 366
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {115 ps}
