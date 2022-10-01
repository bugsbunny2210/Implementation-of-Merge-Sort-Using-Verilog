`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2022 23:32:57
// Design Name: 
// Module Name: merge_sort_sv_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module merge_sort_vsd_tb;
    reg clk,res;
    reg [31:0] data_bus;
    wire [31:0] op;
    integer k;
    parameter def_value=32'h7f7f_ffff;
    merge_sort_vsd ms(.op(op),.clk(clk),.res(res),.data_bus(data_bus));
    initial
        begin
            clk=1'b0;
            forever #3 clk=~clk;
        end
    initial
        begin
         res=1;
        
         for(k=0;k<16;k=k+1)
            begin
                ms.reg_bank[k]=def_value;
            end
        
         #4 res=0;data_bus=32'b10111101101110000101000111101100;
         #12 data_bus=32'b00111111000000000000000000000000;
         #6 data_bus=32'b01000000110000000000000000000000;
         #6 data_bus=32'b11000000010000000000000000000000;
         #6 data_bus=32'b01000001001100000000000000000000;
         #6 data_bus=32'b01000001000100000000000000000000;
         #6 data_bus=32'b01000000100010111000010100011111;
         #1500 $finish;
        end
endmodule



//         #6 data_bus=32'd18;
//         #6 data_bus=32'd4;
//         #6 data_bus=32'd12;
//         #6 data_bus=32'd51;
//        #6 data_bus=32'd42;
//         #6 data_bus=32'd33;
//         #6 data_bus=32'd71;
//         #6 data_bus=32'd111;
//        #6 data_bus=32'd0;