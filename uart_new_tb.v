`timescale 1ns / 1ps
`define clk_period 10 
module uartnew_tb();

reg clk=0;
reg rst;
//reg [7:0]  internal2;
reg rx_serial;
reg rd_en_i;
reg wr_en_i;
//wire done;
wire [7:0] data_o;

topmod topmod(
.clk(clk),
.rst(rst),
.rx_serial(rx_serial),
.empty_o(empty_o),
.full_o(full_o),
.wr_en_i(wr_en_i),
.rd_en_i(rd_en_i),
//.done(done),
.data_o(data_o)
);
                                    

always #(`clk_period/2) clk<=~clk;
                                                        
initial begin

rst=0;
#50
rst=1;
#15
rst=0;

//wr_en_i=1;
//internal2=8'b11110001;
#4340;
rx_serial=0;
#4340;
rx_serial=0;
#4340;
rx_serial=1;
#4340;
rx_serial=0;
#4340;
rx_serial=0;
#4340;
rx_serial=1;
#4340;
rx_serial=1;
#4340;
rx_serial=1;
#4340;
rx_serial=1;
#4340;
#10
wr_en_i=0;
#4340
//Write
    wr_en_i=1'b1;
    rd_en_i=1'b0;
//Read
#500;
wr_en_i=1'b0;
rd_en_i=1'b1;
#5000

//Write
    wr_en_i=1'b1;
    rd_en_i=1'b0;
    #500;
//Read
wr_en_i=1'b0;
rd_en_i=1'b1;
#500;                                           
$finish();
end
endmodule
