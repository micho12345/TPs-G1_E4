if {[catch {

# define run engine funtion
source [file join {D:/2023.2.0.38.1_Radiant} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/sin_test"
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- sin_test_sin_test.vm sin_test_sin_test.ldc
run_engine_newmsg synthesis -f "sin_test_sin_test_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o sin_test_sin_test_syn.udb sin_test_sin_test.vm] [list {D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/sin_test/sin_test/sin_test_sin_test.ldc}]

} out]} {
   runtime_log $out
   exit 1
}
