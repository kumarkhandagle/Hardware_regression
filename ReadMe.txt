Objective:  
1. To build a Custom Processor capable of initiating AXI Write and Read transactions with the DUT (Design Under Test).

Intern_Work v1  
To develop a regression TCL script to run multiple test cases. Each test case will have an independent module design for its respective sequence. The script should:  
1. Add new testbench files (module TB) for every test sequence.  
2. Detect the number of modules/test scenarios added by other users.  
3. Initialize the simulation environment.  
4. Choose one test case as the top module.  
5. Execute the selected test case on the simulator.  
6. Analyze assertion and coverage data.  
7. Move to the next test case automatically.  
8. Show the total time taken to finish executing all added test sequences.


Contributors and Responsibilities:  

1) Yue & Venkatesh  
   1. Set up the project and configure the environment for execution.  
   2. Develop regression logic.  
   3. Identify failures and trigger necessary actions.  
   4. Detect the start and end of simulations.  
   5. Notify Anudeep and Mihir of simulation events.  

2) Anudeep  
   1. Read simulation logs.  
   2. Identify assertion passes and failures.  
   3. Mark results using appropriate colors in an Excel sheet.  

3) Mihir  
   1. Read simulation logs and store coverage data for each coverpoint.  
   2. Highlight data using colors to indicate stimulus improvement areas.  
   3. Subscribe to the monitor class for runtime coverage analysis.  




