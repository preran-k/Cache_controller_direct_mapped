`timescale 1ns / 1ps

module valid(
    input [3:0] index,
    input clk,
    input rst,
    input valid_write_en,
    output valid
    );
    reg valid_array[0:15];
    integer i;
    
    always@(posedge clk or negedge rst)begin
        if(!rst)begin
            for(i=0;i<16;i=i+1)begin
            valid_array[i]=1'b0;
            end
        end
        else begin
            if(valid_write_en)valid_array[index]<=1'b1;
            
        end
        
    end
    assign valid=valid_array[index];
endmodule
