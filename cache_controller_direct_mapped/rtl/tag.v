`timescale 1ns / 1ps

module tag(
    input clk,tag_write_en,
    input [3:0] index,
    input [25:0] tag_cpu,
    output [25:0] tag_cache
    );
    reg [25:0] tag_array[0:15];
    always@(posedge clk)begin
        if(tag_write_en) tag_array[index]<=tag_cpu;
    end
    assign tag_cache=tag_array[index];
endmodule
