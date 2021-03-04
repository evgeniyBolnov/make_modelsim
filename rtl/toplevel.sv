module toplevel (
  input         reset_n               ,
  input         serial_clk            ,
  input         serial_data           ,
  output [ 1:0] parallel_data         ,
  input  [ 2:0] timer_csr_address     ,
  input  [15:0] timer_csr_writedata   ,
  output [15:0] timer_csr_readdata    ,
  input         timer_csr_chipselect  ,
  input         timer_csr_write_n     ,
  output        timer_irq_irq         ,
  input         uart_rxd              ,
  output        uart_txd              ,
  input  [ 2:0] uart_csr_address      ,
  input         uart_csr_begintransfer,
  input         uart_csr_chipselect   ,
  input         uart_csr_read_n       ,
  input         uart_csr_write_n      ,
  input  [15:0] uart_csr_writedata    ,
  output [15:0] uart_csr_readdata     ,
  output        uart_irq_irq
);

    uart u1 (
      .clk_clk               (serial_clk            ), //      clk.clk
      .reset_reset_n         (reset_n               ), //    reset.reset_n
      .uart_csr_address      (uart_csr_address      ), // uart_csr.address
      .uart_csr_begintransfer(uart_csr_begintransfer), //         .begintransfer
      .uart_csr_chipselect   (uart_csr_chipselect   ), //         .chipselect
      .uart_csr_read_n       (uart_csr_read_n       ), //         .read_n
      .uart_csr_write_n      (uart_csr_write_n      ), //         .write_n
      .uart_csr_writedata    (uart_csr_writedata    ), //         .writedata
      .uart_csr_readdata     (uart_csr_readdata     ), //         .readdata
      .uart_rxd              (uart_rxd              ), //     uart.rxd
      .uart_txd              (uart_txd              ), //         .txd
      .uart_irq_irq          (uart_irq_irq          )  // uart_irq.irq
    );

  timer u0 (
    .clk_clk             (serial_clk          ),
    .reset_reset_n       (reset_n             ),
    .timer_csr_address   (timer_csr_address   ),
    .timer_csr_writedata (timer_csr_writedata ),
    .timer_csr_readdata  (timer_csr_readdata  ),
    .timer_csr_chipselect(timer_csr_chipselect),
    .timer_csr_write_n   (timer_csr_write_n   ),
    .timer_irq_irq       (timer_irq_irq       )
  );

  lvds_rx lvds_rx_inst (
    .rx_inclock(serial_clk   ),
    .rx_in     (serial_data  ),
    .rx_out    (parallel_data)
  );


endmodule 