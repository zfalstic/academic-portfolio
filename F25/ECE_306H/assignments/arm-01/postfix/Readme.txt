This is a bare bones project for running ARM assembly code on
a Emulated Virtual ARM Cortex-M0 on QEMU

Demonstrates how postfix work in assembly
	* Assumes infix expression in memory at InFix
	* Reads infix and converts to postfix placing it on stack
	* Evaluates postfix and writes Result to memory

The boot.s file in the libs folder does the "startup" and then
transfers control to the main by calling it like a subroutine.

 
To build:
  $ make

Run the Emulator in a bash shell:
  $ armqemu obj/postfix.elf 

(armqemu is an alias for: "qemuarm -machine virt -kernel $1 -nographic -S -s"
 declared in .bashrc)

Open the Debugger in a bash shell:
  $ armgdb obj/postfix.elf 


All your work will be in Debugger except if there is Keyboard Input/Output

Debugger Commands:
   * To connect to the Emulator:
     	target extended-remote :1234
   * To set breakpoint
        b <label>
     Example: b main

*** Remove any local .gdbinit: Make sure the global .gdbinit
 is the one that uses the dashboard for arm (modified by Ram
esh Yerraballi). To do local customization edit the ~/.gdbin
it.d/init file.
