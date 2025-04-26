
# Check if the variable proj_name is set
if {![info exists proj_name] || $proj_name == ""} {
    puts "ERROR: No project name provided. Set 'proj_name' before sourcing the script."
    return
}

# Set project directory
set proj_dir "C:/Venkatesh/NamasteFPGA/$proj_name"
set design_dir "C:/Venkatesh/NamasteFPGA/adder_circuit_tb_week4/design"
set sim_dir "C:/Venkatesh/NamasteFPGA/adder_circuit_tb_week4/sim"

# Check if the project already exists
if { [file exists "$proj_dir/$proj_name.xpr"] } {
    puts "Opening existing project: $proj_name"
    open_project $proj_dir/$proj_name.xpr
} else {
    puts "Creating new project: $proj_name"
    create_project $proj_name $proj_dir -part xc7k70tfbv676-1
    current_project $proj_name
    set_property target_language Verilog [current_project]
    set_property simulator_language Mixed [current_project]
    set_property source_mgmt_mode All [current_project]
}

puts "new proj created with targetlanguage simLanguage, need to add design and sim files after this step"
after 1000


# Add UVM precompiled library for compilation and elaboration
puts "Setting UVM precompiled library (-L uvm)"
set_property -name {xsim.compile.xvlog.more_options} -value {-L uvm} -objects [get_filesets sim_1]
set_property -name {xsim.elaborate.xelab.more_options} -value {-L uvm} -objects [get_filesets sim_1]

puts "UVM switches added"
after 1000

# Add design files to "Design Sources"
puts "Adding design files from: $design_dir"
set design_files [glob -nocomplain -directory $design_dir *.v *.sv]
if {[llength $design_files] > 0} {
        add_files -fileset sources_1 $design_files
} else {
        puts "WARNING: No design files found in $design_dir"
}
puts "adding design files completed, now proceeding to add sim files"
after 1000

# Add simulation files to "Simulation Sources"
puts "Adding simulation files from: $sim_dir"
set sim_files [glob -nocomplain -directory $sim_dir *.v *.sv]
if {[llength $sim_files] > 0} {
    add_files -fileset sim_1 $sim_files
} else {
    puts "WARNING: No simulation files found in $sim_dir"
}
puts "finished adding sim files to sim sources"
after 1000

# Save the project state[SAVE PROJECT IS NOT WORKING]
#save_project
#if {[current_project] == ""} {
#    puts "ERROR: No active project. Cannot save."
#    return
#}
#save_project
#puts "Project saved successfully."
#
#after 2000
#puts "Project setup completed. Design and Simulation files added."

#END_OF_SCRIPT
#cd ../../../../../.././Venkatesh/NamasteFPGA

#questions week 3-
#spawn failed : No error -> can be ignored ? -> CLOSE PREV SIMULATION, SAVE CHANGES AND RE-RUN SIM
#[HDL 9-3756] overwriting previous definition of interface 'add_if' ["C:/Venkatesh/NamasteFPGA/adder_circuit_tb_week3/sim/interface.sv":5]- when there is no previous declaration
#cannot omit port direction for function/task declarations -> for object_utils -> CAN BE IGNORED
# extra print from sco for adder circuit -> why and how to fix ? DEBUG IT, DELAY ISSUE
# error while trying to save_project -> ERROR: [Common 17-163] Missing value for option 'name', please type 'save_project_as -help' for usage info.
# GCC path warning but mingw installed and set up in env variable path ? -> CAN BE IGNORED 
