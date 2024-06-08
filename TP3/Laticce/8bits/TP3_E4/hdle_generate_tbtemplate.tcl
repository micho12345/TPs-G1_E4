lappend auto_path "D:/2023.2.0.38.1_Radiant/scripts/tcl/simulation"
package require tbtemplate_generation

set ::bali::Para(MODNAME) main
set ::bali::Para(PROJECT) TP3_E4
set ::bali::Para(PRIMITIVEFILE) {"D:/2023.2.0.38.1_Radiant/cae_library/synthesis/verilog/iCE40UP.v=iCE40UP"}
set ::bali::Para(TFT) {"D:/2023.2.0.38.1_Radiant/data/templates/plsitft_ice40tp.tft"}
set ::bali::Para(OUTNAME) main_tf
set ::bali::Para(EXT) .v
set ::bali::Para(FILELIST) {"D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/TP3_E4/source/TP3_E4/Comparator.v=work,Verilog,Verilog_2001" "D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/TP3_E4/source/TP3_E4/ModulatingWaves.v=work,Verilog,Verilog_2001" "D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/TP3_E4/source/TP3_E4/TriangularWaves.v=work,Verilog,Verilog_2001" "D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/TP3_E4/source/TP3_E4/Main.v=work,Verilog,Verilog_2001" }
set ::bali::Para(INCLUDEPATH) {"D:/Facultad ITBA/Ano 5/Cuatrimestre 1/E4/TPs-G1_E4/TP3/Laticce/8bits/TP3_E4/source/TP3_E4" }
::bali::GenerateTbTemplate
