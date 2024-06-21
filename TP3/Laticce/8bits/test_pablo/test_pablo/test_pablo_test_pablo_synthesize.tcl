if {[catch {

# define run engine funtion
source [file join {D:/2023.2.0.38.1_Radiant} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/test_pablo"
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- test_pablo_test_pablo.vm test_pablo_test_pablo.ldc
run_engine_newmsg synthesis -f "test_pablo_test_pablo_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o test_pablo_test_pablo_syn.udb test_pablo_test_pablo.vm] [list {D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/test_pablo/test_pablo/test_pablo_test_pablo.ldc}]

} out]} {
   runtime_log $out
   exit 1
}
