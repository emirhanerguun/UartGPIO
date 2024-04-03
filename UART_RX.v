`timescale 1ns / 1ps
module UART_RX #(parameter clkdiv=50000000/115200-1)(
    input clk,
    input rst,
    input rx_serial,
    output reg [7:0]dout
    );
    reg [15:0] cntr;
    reg [3:0] bitcntr;
    reg [2:0]State;
    reg [9:0]data;
    
    always@(posedge clk) begin
        if(rst) begin
            State <= 0;
            cntr<=0;
            bitcntr<=0;
            data <= 10'b11_1111_1111;
        end
        else begin
            case(State)
                2'b00: begin
                    if(!rx_serial) begin 
                        cntr <= cntr+1;
                    if(cntr==clkdiv[15:1]) begin
                    State<=2'b01;
                    cntr<=0;
                    bitcntr<=0;
                    end  
                 end
               end          
                2'b01: begin
                    cntr<=cntr+1;
                    if(cntr==clkdiv) begin
                     cntr<=0;
                     bitcntr<=bitcntr+1;
                     data <= {rx_serial,data[8:1]};
                    end            
                    if(bitcntr == 9) begin
                        bitcntr<=0;
                        State <= 2'b00;
                        dout <= data[7:0];
                    end
                end
            endcase
        end
    end
endmodule
