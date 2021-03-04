`timescale 1ns/1ns

module testbench();

  logic       reset_n       = 1;
  logic       serial_clk    = 0;
  logic       serial_data      ;
  logic [1:0] parallel_data    ;

  logic [ 2:0] timer_csr_address    = 0;
  logic [15:0] timer_csr_writedata  = 0;
  logic [15:0] timer_csr_readdata      ;
  logic [15:0] readdata                ;
  logic [15:0] readdata_uart           ;
  logic        timer_csr_chipselect = 0;
  logic        timer_csr_write_n    = 1;
  logic        timer_irq_irq           ;

  logic        uart_rxd                  ;
  logic        uart_txd                  ;
  logic [ 2:0] uart_csr_address       = 0;
  logic        uart_csr_begintransfer = 0;
  logic        uart_csr_chipselect    = 0;
  logic        uart_csr_read_n        = 1;
  logic        uart_csr_write_n       = 1;
  logic [15:0] uart_csr_writedata     = 0;
  logic [15:0] uart_csr_readdata         ;
  logic        uart_irq_irq              ;

  initial forever #1 serial_clk = ~serial_clk;

  default clocking main @(posedge serial_clk);
  endclocking

  toplevel toplevel_inst (
    .reset_n               (reset_n               ),
    .serial_clk            (serial_clk            ),
    .serial_data           (serial_data           ),
    .parallel_data         (parallel_data         ),
    .timer_csr_address     (timer_csr_address     ),
    .timer_csr_writedata   (timer_csr_writedata   ),
    .timer_csr_readdata    (timer_csr_readdata    ),
    .timer_csr_chipselect  (timer_csr_chipselect  ),
    .timer_csr_write_n     (timer_csr_write_n     ),
    .timer_irq_irq         (timer_irq_irq         ),
    .uart_rxd              (loop                  ),
    .uart_txd              (loop                  ),
    .uart_csr_address      (uart_csr_address      ),
    .uart_csr_begintransfer(uart_csr_begintransfer),
    .uart_csr_chipselect   (uart_csr_chipselect   ),
    .uart_csr_read_n       (uart_csr_read_n       ),
    .uart_csr_write_n      (uart_csr_write_n      ),
    .uart_csr_writedata    (uart_csr_writedata    ),
    .uart_csr_readdata     (uart_csr_readdata     ),
    .uart_irq_irq          (uart_irq_irq          )
  );

  initial 
    begin
      ##20; write(1,2'b11);
      for (int i = 0; i < 10; i++) 
        begin
          ##100;read(0, readdata);
          $display("Status %b", readdata);
          read(1, readdata);
          $display("Control %b", readdata);
        end
    end

    initial
      begin
        ##10;
        readdata_uart = 0;
        do begin
          ##10; read_uart(2, readdata_uart);
        end while(~readdata_uart[6]);
        write_uart(3, 15'h80);
        for (int j = 0; j < 10; j++)
          begin
            ##20; write_uart(1, $random);
            do 
              begin
                ##10; read_uart(2, readdata_uart);
              end while(~readdata_uart[5]);
          end
      end

  initial 
    begin
      ##2 reset_n = 0;
      ##2 reset_n = 1;
      ##1500 $finish;
    end

  always_ff @(serial_clk)
    serial_data <= $random();

  always_ff @(posedge timer_irq_irq)
    write(0,0);

  task write_uart(
      input logic [2:0] addr,
      input logic [15:0] data
    );
    wait(~uart_csr_chipselect);
    @(posedge serial_clk);
    uart_csr_address    = addr;
    uart_csr_writedata  = data;
    uart_csr_write_n    = 0;
    uart_csr_chipselect = 1;
    uart_csr_begintransfer = 1;
    @(posedge serial_clk);
    uart_csr_begintransfer = 0;
    @(posedge serial_clk);
    uart_csr_write_n    = 1;
    uart_csr_address    = 0;
    uart_csr_writedata  = 0;
    uart_csr_chipselect = 0;
  endtask : write_uart

  task read_uart(
      input logic [2:0] addr,
      output logic [15:0] data
    );
    wait(~uart_csr_chipselect);
    @(posedge serial_clk);
    uart_csr_address    = addr;
    uart_csr_chipselect = 1;
    uart_csr_read_n     = 0;
    uart_csr_begintransfer = 1;
    @(posedge serial_clk);
    uart_csr_begintransfer = 0;
    @(posedge serial_clk);
    data                = uart_csr_readdata;
    uart_csr_read_n     = 1;
    uart_csr_address    = 0;
    uart_csr_chipselect = 0;
  endtask : read_uart

  task write(
      input logic [2:0] addr,
      input logic [15:0] data
    );
    wait(~timer_csr_chipselect);
    @(posedge serial_clk);
    timer_csr_address    = addr;
    timer_csr_writedata  = data;
    timer_csr_write_n    = 0;
    timer_csr_chipselect = 1;
    @(posedge serial_clk);
    timer_csr_write_n    = 1;
    timer_csr_address    = 0;
    timer_csr_writedata  = 0;
    timer_csr_chipselect = 0;
  endtask : write

  task read(
      input logic [2:0] addr,
      output logic [15:0] data
    );
    wait(~timer_csr_chipselect);
    @(posedge serial_clk);
    timer_csr_address    = addr;
    timer_csr_chipselect = 1;
    @(posedge serial_clk);
    @(posedge serial_clk);
    data                 = timer_csr_readdata;
    timer_csr_address    = 0;
    timer_csr_chipselect = 0;
  endtask : read

endmodule