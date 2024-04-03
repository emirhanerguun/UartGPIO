`timescale 1ns / 1ps

module hw6_top(
input clk,
input rst,
input  rx_serial,
//output  done,

input wr_en_i,
input rd_en_i,
output full_o,
output [7:0] data_o,
output empty_o
);
wire [7:0] internal2;
wire ledA;
wire ledB;
topmod topmod(
.clk(clk),
.rst(rst),
.rx_serial(rx_serial),
//.done(done),
.wr_en_i(ledA),
.rd_en_i(ledB),
.full_o(full_o),
.data_o(data_o),
.empty_o(empty_o)
);  

debouncer debounce1(
.clk(clk),
.signal_i(wr_en_i),
.signal_o(ledA)
    );
debouncer debounce2(
.clk(clk),
.signal_i(rd_en_i),
.signal_o(ledB)
    );
   
endmodule
