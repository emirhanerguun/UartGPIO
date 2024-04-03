`timescale 1ns / 1ps
module topmod(
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
reg [7:0] internal;
wire [7:0] internal2;
reg [3:0] cnt;
wire [7:0] dout;
wire [7:0] data_i;

wire tx_serial;
    
UART_TX UART_TX(
.clk(clk),
.rst(rst),
.din(internal),
.enable(wr_en_i),
//.done(done),
.tx_serial(tx_serial)
);

UART_RX UART_RX(
    .clk(clk),
    .rst(rst),
    .rx_serial(rx_serial),
    .dout(dout)
);

sync_fifo SYNC_FIFO(
.clk(clk),
.rst(rst),

.wr_en_i(wr_en_i),
.data_i(data_i),

.rd_en_i(rd_en_i),
.data_o(data_o),

.full_o(full_o),
.empty_o(empty_o)
);
//assign data_i=dout;
always @( posedge clk )begin
if(rst==1'b1)
cnt<=0;
if(empty_o && !full_o && cnt==0) begin
internal<=8'b01100101; //e
//cnt<=cnt+1;
end
else if(!empty_o && full_o && cnt==0) begin
internal<=8'b01100110; //f
//cnt<=cnt+1;
end
else if(internal<=8'b01100101 && cnt==0)
cnt<=1;
end

assign data_i = (cnt==0) ? internal:dout;

endmodule
