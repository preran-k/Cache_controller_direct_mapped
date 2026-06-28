`timescale 1ns / 1ps

module fsm_cache(
    input clk,rst,cpu_req,
    input mem_ready,hit,
    output reg mem_read,cpu_ready,
    output reg valid_we,tag_we,cache_data_we
    );
    
    parameter IDLE=0,COMPARE=1,HIT=2,MISS=3,MEM_WAIT=4,UPDATE=5,DONE=6;
    
    reg [2:0] state,next;
    
    always@(posedge clk or negedge rst)begin
        if(!rst)begin
            state<=IDLE;
        end
        else state<=next;
    end
    
    always@(*)begin
                mem_read=0;
                cpu_ready=0;
                valid_we=0;
                tag_we=0;
        case(state)
            IDLE:begin
                cache_data_we=0;
                if(cpu_req)begin
                    next=COMPARE;
                end
                else next=IDLE;
            end
            
            COMPARE:begin
                if(hit) next=HIT;
                else next=MISS;
            end
            HIT:begin
                cpu_ready=1;
                next=IDLE;
            end
            MISS:begin
                mem_read=1;
                next=MEM_WAIT;
            end
            MEM_WAIT:begin
                mem_read=1;
                if(mem_ready)begin
                    next=UPDATE;
                end
                else next=MEM_WAIT;
            end
            UPDATE:begin
                valid_we=1;
                tag_we=1;
                cache_data_we=1;
                next=DONE;
            end
            DONE:begin
                cpu_ready=1;
                next=IDLE;
            end
            default:next=IDLE;
        endcase
    end
endmodule
