`timescale 1ns / 1ps

module data_cache(
    input clk,
    input [3:0] index,
    input cache_data_we,
    input [127:0] cache_data_in,
    output [127:0] cache_data_o
    );
    reg [127:0] data_array [0:15];
    
    always@(posedge clk)begin
        if(cache_data_we)begin
            data_array[index]<=cache_data_in;
        end
    end
    
    assign cache_data_o=data_array[index];
endmodule
