Design and Verification of A Completed CPU

1/ Introduction to the project
In this project, the simple design of a CPU module, running in a RISC architecture is conducted and its implementation and configuration is verified through the Hardware Description Language (HDL). Indeed, the design and verification of the CPU is described through the System Verilog HDL, developed in the Quartus Prime Lite software for code editing and synthesis, and the Modelsim software for running simulation and waveform observation. The devices family used for running and simulating the project is Cyclone-V.

2/ Brief Instruction set of the CPU
The CPU developed in this project is much simplier than the outside marketable CPU system, as it is scaled to the RISC architecture, and its execution is done through manual inputing the intruction, rather than the automatic process of fetch-execute cycle as usual. Generally, the operation of the entire system is shown as below image:

<img width="494" alt="image" src="https://github.com/user-attachments/assets/e876489f-b44c-4aa7-92b1-9bff7ad90b83">

In the block diagram, the host system of the CPU send the operation code to the control unit module. The control unit then proceeds the opcode data and generates the relevant output data, which are the enabling of register A/B/out data write, the F selection for ALU combinational module, and the selection of input ports for multiplexer 4x1. With proper input signal for the submodules, they will execute their operation internally and user should observe the final output data as the write_o register is enabled. Detailed explanation of each modules are described in the code. 

3/ Result Analysis & Reflection:
- Overall, the program is able to run and respond a correct output with several stimulus applied when running the simulation, as indicated in the waveforms.
- Successful connections between different IPs such as ALU, Registers A/B/Out and the MUX41 using module instantiations.
- The waveform is extended to observe the internal signal behaviours such as the ALU C bus, the registers A and B output, the control unit flags proceeding, or the multiplexer 4x1 implementation.
- The testbench is simple where the stimulus is generated through txt file, read through $readmemb and applied some assertions to fire whenever the actual output is different from the expected one -> probably reduce simulation and testing time by 20%, comparing to manually applied the single signal to the DUT. 
- Because the conditions of the RTL design are not fully covered, for example, all of the cases presented by F_sel[3:0] inside the ALU are not addressed, there still might be some issues if that specific case is accessed -> probably 90% logical correctness since there might be some potential hidden bugs of cases not yet addressed.

4/ Further improvement:
- The testbench environment can be improved by developing some classes such as constrained random sequence items generator, driver driving transaction data to the DUT, monitor capturing DUT pins and convert to transaction data sending to scoreboard, and scoreboard to compare the expected data with their actual counterparts. The communication between these classes can be acheived through mailbox, event, interface. This would effective reduce time of simulation and enhance code effectiveness.
- Consider applying UVM testbench environment instead of pure SV code above to enhance readability, resuseability, and flexibility of the code. The UVM testbench can be created with UVM components such as uvm_sequencer, uvm_sequence, uvm_driver, uvm_agent, uvm_monitor, uvm_scoreboard, uvm_config_db, etc.. Put the components to the UVM hierarchy then more and more CPU subsystems can be verified with reused UVM testbench environment. UVM phases including Build phase, Run phase, and Cleanup phase are conducted in a simulation flow.
- The UVM is simply the transaction-level modelling methodology class-based library used to enhance the effectiveness of the testbench environment, as well as develop to have a reusability among multiple IPs, subsystems or SoC. The communication between UVM components is done by transaction data being transfered using mailbox, class polymorphism, inheritance, etc..
- SVA and SFC could help to extend the verification effectiveness and avoidance of bugs, inadequate coverage. SVA properties are placed alongside every operation of the system such as ALU signal, control unit sequential procedure, to identify the direct sources of bug whenever issues are rised, as "assert" keywords identify the bugs, it immediately announce the location of the bugs as they are placed so near to the source of issue. The "cover" keyword in SVA allows user to fully cover all the assertions created within the environments. Coveraging the assertions means that do all the operations of the system have been covered with assertions alarming, does there any places where the assertions are actually not be exercised, if yes, then as the assertions are not fired, is that the case where there are still some operational conditions have not been exercised, or simply the system is fully corrected without bugs?


