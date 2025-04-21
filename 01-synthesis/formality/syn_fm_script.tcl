
set top_module cv32e40p_top

set RTL       "/mnt/hgfs/share/GP/rtl"
set LIB_PATH  "/mnt/hgfs/share/GP/library/saed_14_pdk/stdcell_hvt/db_ccs"

lappend search_path $LIB_PATH
lappend search_path $RTL


set SSLIB "saed14hvt_ss0p6v125c.db" 
set TTLIB "saed14hvt_tt0p6v125c.db" 
set FFLIB "saed14hvt_ff0p7v125c.db"


set synopsys_auto_setup true

set_svf "./${top_module}.svf"

read_sverilog  -container Ref cv32e40p_top.sv

read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

set_reference_design cv32e40p_top
set_top cv32e40p_top


read_verilog -container Imp -netlist "/mnt/hgfs/share/GP/synthesis/output/${top_module}.v"

read_db -container Imp [list $SSLIB $TTLIB $FFLIB]


set_implementation_design cv32e40p_top
set_top cv32e40p_top


match


set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

report_passing_points > ./report/passing_points.rpt
report_failing_points > ./report/failing_points.rpt
report_aborted_points > ./report/aborted_points.rpt
report_unverified_points > ./report/unverified_points.rpt

