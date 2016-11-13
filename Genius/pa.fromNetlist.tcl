
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name Genius -dir "C:/Users/Kaue/Dropbox/Lab4/Genius/VHDL/Genius/planAhead_run_4" -part xc3s1200efg320-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Kaue/Dropbox/Lab4/Genius/VHDL/Genius/main.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Kaue/Dropbox/Lab4/Genius/VHDL/Genius} }
set_property target_constrs_file "pins.ucf" [current_fileset -constrset]
add_files [list {pins.ucf}] -fileset [get_property constrset [current_run]]
link_design
