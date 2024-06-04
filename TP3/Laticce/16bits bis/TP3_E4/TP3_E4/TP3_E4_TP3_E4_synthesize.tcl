if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2023.2} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "C:/Users/pedro/OneDrive/Escritorio/ITBA/TP3/Laticce/16bits/TP3_E4"
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- TP3_E4_TP3_E4.vm TP3_E4_TP3_E4.ldc
run_engine_newmsg synthesis -f "TP3_E4_TP3_E4_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o TP3_E4_TP3_E4_syn.udb TP3_E4_TP3_E4.vm] [list C:/Users/pedro/OneDrive/Escritorio/ITBA/TP3/Laticce/16bits/TP3_E4/TP3_E4/TP3_E4_TP3_E4.ldc]

} out]} {
   runtime_log $out
   exit 1
}
