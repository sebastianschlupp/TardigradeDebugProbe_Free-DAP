# Tardigrade Marine Debug Probe

This repository hosts the Free-DAP adaptation to the Tardigrade Marine Debug Probe Hardware

## Free-DAP

This is a free and open implementation of the CMSIS-DAP debugger firmware.

Both SWD and JTAG protocols are supported. However JTAG was not well tested due to lack of
good targets. If you have any issues with it - let me know and I'll try to help.

# Build instructions

The repository is designed to be built inside Visual Studio Code. A workspace file is incldued 
which will also prompt the user to install the required extensions and configures the workspace
accordingly.
You will also need the ARM GNU Toolchain installed on your device:
(for bare-metal targets from: https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)

## Folder structure

For the build to work, it is necessary to clone the repo into its on folder. Next to this folder
it is also needed to clone the latest free-dap repository. The folder this repository is cloned 
into shall be named TM-DBG. The folder the free-dap repository is cloned into shall be named 
free-dap. If you prefer to use other names you need to modify the .code-workspace file as well as
the makefile.

/  
│  
├── TM-DBG (https://github.com/sebastianschlupp/TardigradeDebugProbe_Free-DAP)  
│  
└── free-dap (https://github.com/ataradov/free-dap)  

## Toolchain paths

For a successful build it is necessary to make sure the following environment variable is set:
GNUARMEMB_TOOLCHAIN_PATH ( on OS X, for example to 
/Applications/ARMGNUToolchain/13.2.Rel1/arm-none-eabi/bin)
If this is not set, the makefile falls back to the OS X specific (please adjust inside makefile
if you use a different version of the ARMGNUToolchain):
/Applications/ARMGNUToolchain/13.2.Rel1/arm-none-eabi/bin

For the workspace you will need to set the "C_Cpp.default.includePath" to point to the ARM GNU
Toolchain as well.

## Build steps

Open a terminal, either in VS code or directly in your favorite shell, switch to the TM-DBG folder
and just run make.
