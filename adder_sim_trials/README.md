
18/4/25
=================================
o adder_files/ directory summary:
=================================
- adder_files/ directory added which consists of design/ and sim/ files that are required to run simulation at your end locally
- design/ has a 4-bit adder
- sim/ has all the class based TB components
- we currently have 2 testcases: fixed and random
- as I have not yet found a way to pass runtime switches in Xilinx that enables us to run different test/sequences from command line options, I have separated module, test & sequence into (top_fixed, top_random modules), (test_fixed, test_random tests) and (sequence_fixed, sequence_random sequences)

=================================
o TCL script summary:
=================================
- to use the script from your tcl console on vivado, please set the proj_name variable using command: set proj_name <any_name_you_want>
- once you have cloned the repo, you need to update the path for design_dir & sim_dir as per the path that you have in your local area so that the script can automatically read and load the desgin and sim files for you in the <proj_name>_dir_ that you create.
- next, source the tcl script using the command source ./setup_project-wip.tcl
- once you have sourced, the project loads and you will be able to see the files in design and simulation sources with UVM switches also added into the settings. 
- To run, you need to manually right click and select the test you want to run- either top_fixed or top_random


