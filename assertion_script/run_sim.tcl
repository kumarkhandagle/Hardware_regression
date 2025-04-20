# package require tcom - this is if we're trying to run the script outside of vivado

# Open the simulation log file
set log_file "Your_Directory../project_adder.sim/sim_1/behav/xsim/simulate.log"  
set out_file "Your_Directory../project_adder.sim/sim_1/behav/xsim/assertion_results.xlsx"

# Mentioning the assertions that are defined in the test environment 
set expected_assertions {ASSRT1 ASSRT2}  

# Opening the log files for reading
set log_channel [open $log_file r]
set out_channel [open $out_file w]

#writing to the csv file
puts $out_channel "Time (ns),Assertion,Status"

# Reading log file line by line
while {[gets $log_channel line] != -1} {
    # Looking for assertion failures
    if {[regexp {Error: \[(ASSRT[0-9]+)\] Assertion failed at ([0-9]+)} $line -> assert_name timestamp]} {
        puts $out_channel "$timestamp,$assert_name,FAIL"
    }
	#elseif {[regexp {\[(ASSRT[0-9]+)\].*at ([0-9]+)} $line -> assert_name timestamp]} {
    #    puts $out_channel "$timestamp,$assert_name,PASS"
    #}
}




# Close file channels
close $log_channel
close $out_channel

puts "Assertion results saved in $out_file"
