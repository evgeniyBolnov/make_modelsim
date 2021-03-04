# Тестовый пример использования makefile с Modelsim

## Варианты применения
- `make`(`make com`) - компиляция исходников
- `make sim` - запуск симуляйии в консоли
- `make gui` - запуск симуляйии в приложении
- `make gtkwave` - запуск симуляйии и открытие waveform в gtkwave
- `make qsyscom` - компиляция qsys
- `make qsyscom_force` - форсированная компиляция qsys
- `make coverage` - симуляция в консоли и генерация отчетов о покрытии
- `make clean` - очистка от результатов компиляции исходников
- `make qsysclean` - очистка от результатов компиляции qsys
- `make cleanall` - очистка от всех результатов компиляции 

## Вариант использования

```makefile
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

# Used library
LIBRARY = altera_mf

# Custom paths to binaries
MODELSIM_BIN_PATH := C:/modeltech64_10.6d/win64
QUARTUS_ROOTDIR   := C:/intelFPGA/18.1/quartus

# Include main makefile
include ./modelsim.mk
```
