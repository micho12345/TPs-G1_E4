if {[catch {

# define run engine funtion
source [file join {D:/2023.2.0.38.1_Radiant} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/FPGA"
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- FPGA_FPGA.vm FPGA_FPGA.ldc
run_engine_newmsg synthesis -f "FPGA_FPGA_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o FPGA_FPGA_syn.udb FPGA_FPGA.vm] [list {D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/FPGA/FPGA/FPGA_FPGA.ldc}]

} out]} {
   runtime_log $out
   exit 1
}
