#-- Lattice Semiconductor Corporation Ltd.
#-- Bitgen run script generated by Radiant

set ret 0
if {[catch {

sys_set_attribute -gui on -msg {D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/FPGA/promote.xml}
msg_load {D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/FPGA/promote.xml}
des_set_project_udb -in {FPGA_FPGA.udb} -milestone bit -pm ice40tp
# bitgen option
bit_set_option { output_format "binary" run_drc true  no_header false initialize_ebr_quadrant_0 true initialize_ebr_quadrant_1 true initialize_ebr_quadrant_2 true initialize_ebr_quadrant_3 true oscillator_frequency_range slow spi_flash_low_power_mode false enable_warm_boot false set_nvcm_security false }
#-- write result file
bit_generate -w {D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/FPGA/FPGA/FPGA_FPGA}

} out]} {
   runtime_log $out
   set ret 1
}

exit -force ${ret}