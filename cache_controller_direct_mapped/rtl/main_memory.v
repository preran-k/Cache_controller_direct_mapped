`timescale 1ns / 1ps

module main_memory(
    input clk,rst,
    input [29:0] cpu_addr,
    input mem_read,
    output [127:0] main_mem_o,
    output reg mem_ready
    );
    reg [127:0] main_mem [0:255];
    reg [2:0] count;
    parameter DELAY=5;
    
    initial begin
        main_mem[0]=128'h00000000000000000000000000000001;
        main_mem[1]=128'h00000000000000000000000000000111;
    end
    
    always@(posedge clk or negedge rst)begin
        if(!rst)begin
            count<=0;
            mem_ready<=0;
        end
        else begin
            if(mem_read&&(count<DELAY+1))begin
                count<=count+1;
                mem_ready<=0;
            end
            else count<=0;
            if(count==DELAY)begin
                mem_ready<=1; 
            end
            else mem_ready<=0;
        end
    end
    
    assign main_mem_o=main_mem[cpu_addr];
endmodule
