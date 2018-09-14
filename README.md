# Configuration for debugging on WSL with VS Code

This repository demonstrates one way to configure Visual Studio Code to debug command-line applications running on the Windows Subsystem for Linux (WSL) with GDB.
I know it works for C and probably C++.
I'd imagine this should work for other languages that can be debugged through GDB, but I haven't experimented with it.

## The problem

Visual Studio Code allows you to debug programs running in the Windows Subsystem for Linux by calling GDB through bash.
However, there's no built-in way to interact with your application through the command line.

One potential solution to this is to start your application separately and then attach the debugger.
The configuration in this repository provides a way to debug your application from the start and connect it to a terminal.

## How it works

The task file in the `.vscode` folder references two scripts: the _build_ task and the _prelaunch_ task.
The build task reads `.vscode/config/launchtemplate.json` and fills the paths referring to the current working directory with the way it's represented in WSL
(e.g. `/mnt/c/` instead of `C:\\`).
`launchtemplate.json` tells the debug platform to pipe through bash in order to run GDB
and sets GDB's `tty` setting to a location in your Linux home directory.
The build script ends by running `make`.

When you begin the debug process (or press `F5`) the prelaunch task is run.
This task opens bash in a new window,
creates a symbolic link to the current `tty` file in your Linux home directory,
and calls `sleep infinity`.
Visual Studio Code will start GDB, which will direct the standard IO for your program to the terminal opened in the prelaunch task.

## How to use this

- First, ensure that you have installed the Windows Subsystem for Linux and any Linux command-line utilities you need to compile and debug your code (especially GDB).

- In Visual Studio Code on Windows, copy the `.vscode` folder into your working directory.
- Make any modifications you need in `tasks.json` and the associated bash scripts.
- Make any necessary modifications to your launch configuration in `launchtemplate.json`.
- Create a Makefile or otherwise modify the build script to suit your needs.
- Each time you run the build task it will compile your code and generate `.vscode/launch.json`.
- After `launch.json` has been created, start debugging.
If all goes well, the debugger will start and a terminal that pipes input and output to your program will appear.

## Conclusion

This is something I set up for a project I was working on and I figured I'd share it.
I'm not an expert in any of this stuff so I can't guarantee it will work for everyone.
If there are any problems in here or if something could have been done better, feel free to create an issue or a pull request.