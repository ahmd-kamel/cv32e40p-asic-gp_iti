set search_path "/home/synopsys/syn/O-2018.06-SP1/libraries/syn/dw_foundation.sldb \
		/mnt/hgfs/share/GP/library/saed_14_pdk/stdcell_hvt/db_ccs \
		/mnt/hgfs/share/GP/library/saed_14_pdk/stdcell_rvt/db_ccs"
set target_library "saed14hvt_ss0p6v125c.db"
set link_library "* $target_library"

sh rm -rf work
sh mkdir work
define_design_lib work -path ./work

set design_name cv32e40p_top

#set dc_allow_rtl_pg true
#set hdlin_keep_power_ground_pins true

read_file -format sverilog ../rtl/${design_name}.sv

analyze -library work -format sverilog ../rtl/${design_name}.sv
elaborate $design_name -lib work

current_design
check_design

source -e -v ./cons/cv32e40p_core.sdc

source -e -v ./scripts/helper.tcl


link
compile -map_effort medium
ungroup -flatten -all
#compile_ultra

report_area > ./report/synth_area.rpt
report_cell > ./report/synth_cells.rpt
report_qor > ./report/synth_qor.rpt
report_resources > ./report/synth_resources.rpt
report_timing -max_paths 10 -delay_type max > ./report/synth_timing_setup.rpt
report_timing -max_paths 10 -delay_type min > ./report/synth_timing_hold.rpt
report_constraint -all_violators > ./report/synth_violators.rpt


#define_name_rules no_case -case_insensitive
#change_names -rule no_case -hierarchy
#change_names -rule sverilog -hierarchy

set verilogout_no_tri true
set verilogout_equation false

write_sdc output/${design_name}.sdc
write -hierarchy -format verilog -output ./output/${design_name}.v
write -f ddc -hierarchy -output ./output/${design_name}.ddc

#gui_start

