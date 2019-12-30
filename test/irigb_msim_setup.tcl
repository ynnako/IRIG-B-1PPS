

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "irig_b_1pps_tb"
}

if ![info exists SIM_DIR] { 
  set SIM_DIR "./../"
}


# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}


# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/


# ----------------------------------------
# Compile the design files in correct order
alias com {
		vcom -2008 -work work $SIM_DIR/vhdl/test_bench/irig_b_1pps_tb_pack.vhd																																						
		vcom -2008 -work work $SIM_DIR/vhdl/pack/irig_b_pack.vhd													
    	vcom -2008 -work work $SIM_DIR/vhdl/test_bench/msg_reader.vhd										
    	vcom -2008 -work work $SIM_DIR/vhdl/test_bench/file_writer.vhd																											
		vcom -2008 -work work $SIM_DIR/vhdl/global/pps_gen.vhd
		vcom -2008 -work work $SIM_DIR/vhdl/global/oled_wrapper.vhd
		vcom -2008 -work work $SIM_DIR/vhdl/global/ascii_converter.vhd		
		vcom -2008 -work work $SIM_DIR/vhdl/global/symbol_decoder.vhd																																						
		vcom -2008 -work work $SIM_DIR/vhdl/global/time_decoder.vhd																									       											
		vcom -2008 -work work $SIM_DIR/vhdl/global/sync.vhd																																						
		vcom -2008 -work work $SIM_DIR/vhdl/global/irig_b_top.vhd																																						
		vcom -2008 -work work $SIM_DIR/vhdl/test_bench/irig_b_1pps_tb.vhd																																						
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS -L work  $TOP_LEVEL_NAME
	do do_files/irig_b_wave.do
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -novopt -t ps $ELAB_OPTIONS -L work -novopt $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "SIM_DIR                       -- Simulation directory."
  echo

}
h
