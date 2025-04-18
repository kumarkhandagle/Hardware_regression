# set env
#===================
# HERE IS THE DIR
#===================
set project_dir "O:/File_SVprojects/week3"
set sim_dir "$project_dir/week3.sim/sim_1/behav/xsim"
file mkdir $sim_dir
catch {file delete -force [file join $sim_dir xsim.dir]}
file mkdir [file join $sim_dir xsim.dir]
catch {file delete -force $sim_dir/*}
puts "Cleaning old simulation files..."

# Clean logs
set junk_exts {log jou pb wdb}
foreach ext $junk_exts {
    foreach file [glob -nocomplain -directory $project_dir *.$ext] {
        catch {file delete -force $file}
    }
}

# Patterns for critical errors
set xvlog_patterns {
    "ERROR: \\[VRFC 10-\\d+\\]"
    "ERROR: \\[VRFC 7-\\d+\\]"
    "syntax error"
    "undeclared"
    "illegal redeclaration"
}
set xelab_patterns {
    "ERROR: \\[XSIM 43-3322\\]"
    "Static elaboration .* failed"
    "port .* not connected"
}
set xsim_patterns {
    "UVM_FATAL"
    "simulation ended prematurely"
    "TIMEOUT: Simulation exceeded"
}

# Timeout setting (sec)
set total_start [clock seconds]

#========================================================================================
# HERE we add top modules into set (then foreach loop will take the set and run automatically
# Define your testbenches here: 
# Format: {src_files top_module sim_snapshot log_file timeout_ns}
# - src_files:       Space-separated .v files (e.g., testbench + DUT)
# - top_module:      Name of the top module in the testbench
# - sim_snapshot:    Name used by xelab/xsim (you can set any unique name)
# - log_file:        Where simulation logs will be saved
# - timeout_ns:      Max simulation time (e.g., 15000 = 15us)
#========================================================================================
set tests {
    {"tb_structural_fail_test.v async_adder.v" tb_structural_fail_test tb_structural_fail_sim tb_structural_fail.log 10000}
    {"tb_async_adder_random.v async_adder.v"   tb_async_adder_random  tb_async_adder_random_sim  tb_async_adder_random.log 15000}
    {"tb_async_adder_fixed.v async_adder.v"    tb_async_adder_fixed   tb_async_adder_fixed_sim   tb_async_adder_fixed.log 15000}
}

#============================================
#My tasks for handle errors/timeout
#============================================
foreach test $tests {
    lassign $test srcs tb sim_name log timeout

    puts "\n---------------------------"
    puts "Running Testbench: $tb"
    set test_result "UNKNOWN"
    set is_structural_error 0
    set compile_error 0
    set timeout_hit 0
    set sim_failed 0
    set sim_time_reported ""

    # Compile
    foreach src [split $srcs] {
        set filepath "$project_dir/week3.srcs/sim_1/new/$src"
        if {[catch {exec xvlog -sv -L uvm $filepath} compile_msg]} {
            puts "Compile failed for $src"
            puts "$compile_msg"
            set compile_error 1
        }
        foreach pattern $xvlog_patterns {
            if {[regexp -nocase $pattern $compile_msg match]} {
                puts "COMPILE ERROR: $match"
                set compile_error 1
            }
        }
    }
    if {$compile_error} {
        puts "TEST:          $tb"
        puts "Result:        COMPILE FAIL"
        puts "---------------------------"
        continue
    }

    # Elaborate
    if {[catch {exec xelab work.$tb -s $sim_name -debug typical} elab_msg]} {
        foreach pattern $xelab_patterns {
            if {[regexp -nocase $pattern $elab_msg match]} {
                puts "ELAB STRUCTURAL ERROR: $match"
                set is_structural_error 1
            }
        }
        puts "TEST:          $tb"
        puts "Result:        STRUCTURE FAIL"
        puts "Elab Message:"
        puts "$elab_msg"
        puts "---------------------------"
        continue
    }

    # Generate run_timeout.tcl
    set rtcl [open "run_timeout.tcl" w]
    puts $rtcl "set MAX_SIM_TIME $timeout"
    puts $rtcl "run \$MAX_SIM_TIME ns"
    puts $rtcl {puts "TIMEOUT: Simulation exceeded limit."}
    puts $rtcl {quit}
    close $rtcl

    # Simulate
    set start_time [clock seconds]
    set run_result [catch {exec xsim $sim_name -tclbatch run_timeout.tcl > $log 2>@1} sim_msg]
    set end_time [clock seconds]
    set duration [expr {$end_time - $start_time}]

    # Analyze log
    set file_handle [open $log r]
    set log_data [read $file_handle]
    close $file_handle

    # SIM TIME
    if {[regexp {SIM DONE at time: ([0-9]+)} $log_data _ sim_time]} {
        set sim_time_reported $sim_time
    }

    # Check if simulation finished normally
set sim_done_found [regexp {SIM DONE at time:} $log_data]

# Check for sim errors or timeout
foreach pattern $xsim_patterns {
    if {[regexp -nocase $pattern $log_data match]} {
        puts "SIM FAIL MATCH: $match"
        if {![string match "*TIMEOUT*" $match]} {
            set sim_failed 1
        }
    }
}



    puts "TEST:          $tb"
    puts "Wall Time:      ${duration} sec"
    if {$sim_time_reported ne ""} {
        puts "Sim Time:      ${sim_time_reported} ns"
    }
    puts "Structure OK:  [expr {!$is_structural_error} ? "YES" : "NO"]"

    if {$timeout_hit} {
    puts "Run Result:    TIMEOUT"
    catch {exec powershell -Command "Stop-Process -Name xsim -Force"}
} elseif {$sim_failed || $run_result != 0} {
    puts "Run Result:    FAILED"
} else {
    puts "Run Result:    COMPLETED"
}


    puts "---------------------------"
}

# Final timing
set total_end [clock seconds]
puts "\nAll testbenches executed."
puts "Total regression time: [expr {$total_end - $total_start}] seconds"
