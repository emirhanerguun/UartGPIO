`timescale 1ns / 1ps
module uartrx_tb();
reg clk=0;
reg rst;
reg rx_serial;
wire  [7:0]dout;
UART_RX UART_RX(
    .clk(clk),
    .rst(rst),
    .rx_serial(rx_serial),
    .dout(dout)
);
always #5 clk=~clk;

initial begin 
rst=0;
#5
rst=1;
#50
rst=0;
#50
rx_serial=0;
#4330;
rx_serial=1;
#4330;
rx_serial=0;
#4330;
rx_serial=0;
#4330;
rx_serial=0;
#4330;
rx_serial=0;
#4330;
rx_serial=0;
#4330;
rx_serial=1;
#4330;
rx_serial=1;
#4330;

$finish();
end
endmodule
