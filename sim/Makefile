# Top level entity
TOP_ENTITY = testbench

# Path and source files
vpath %.sv ../rtl 
vpath %.v ../rtl 
HDL_SRC += toplevel.sv testbench.sv

vpath %.v ../ip
HDL_SRC += lvds_rx.v 

QSYS_LIB_PATH = ../rtl
vpath %.qsys ../qsys
QSYS_SRC      = timer.qsys uart.qsys

LIBRARY = altera_mf

MODELSIM_BIN_PATH := C:/modeltech64_10.6d/win64
QUARTUS_ROOTDIR   := C:/intelFPGA/18.1/quartus

VLOG_OPT = +define+SEED=$(shell date +%s)

include ./modelsim.mk