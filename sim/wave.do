onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/parallel_data
add wave -noupdate /testbench/serial_clk
add wave -noupdate /testbench/reset_n
add wave -noupdate /testbench/serial_data
add wave -noupdate /testbench/timer_csr_address
add wave -noupdate /testbench/timer_csr_chipselect
add wave -noupdate /testbench/timer_csr_readdata
add wave -noupdate /testbench/timer_csr_write_n
add wave -noupdate /testbench/timer_csr_writedata
add wave -noupdate /testbench/timer_irq_irq
add wave -noupdate /testbench/readdata
add wave -noupdate /testbench/toplevel_inst/u1/uart_csr_address
add wave -noupdate /testbench/toplevel_inst/u1/uart_csr_begintransfer
add wave -noupdate /testbench/toplevel_inst/u1/uart_csr_chipselect
add wave -noupdate /testbench/toplevel_inst/u1/uart_csr_read_n
add wave -noupdate /testbench/toplevel_inst/u1/uart_csr_readdata
add wave -noupdate /testbench/toplevel_inst/u1/uart_csr_write_n
add wave -noupdate /testbench/toplevel_inst/u1/uart_csr_writedata
add wave -noupdate /testbench/toplevel_inst/u1/uart_irq_irq
add wave -noupdate /testbench/toplevel_inst/u1/uart_rxd
add wave -noupdate /testbench/toplevel_inst/u1/uart_txd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {774560 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 223
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3157350 ps}
