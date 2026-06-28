`timescale 1ns / 1ps

module cache_top(
    input clk,rst,
    input [31:0] cpu_addr,
    input cpu_req,
    output cpu_ready,
    output [31:0] data_o
    );
    
    wire [3:0] index;
    wire [1:0] offset;
    wire [25:0] tag_cpu;
    wire hit;
    wire valid;
    wire [3:0] index;
    wire [127:0] cache_data_o;
    wire [25:0] tag_cache;
    
    wire mem_read;
    wire [127:0] main_mem_o;
    wire mem_ready;
    wire valid_we,cache_data_we,tag_we;
    
    addr_decoder u1(.cpu_addr(cpu_addr),
    .tag_cpu(tag_cpu),
    .index(index),
    .offset(offset));
    
    compare u2(.valid(valid),
    .tag_cpu(tag_cpu),
    .tag_cache(tag_cache),
    .hit(hit));
    
    valid u3(.index(index),
    .clk(clk),
    .rst(rst),
    .valid_write_en(valid_we),
    .valid(valid));
    
    tag u4(.clk(clk),.tag_write_en(tag_we),
    .index(index),
    .tag_cpu(tag_cpu),
    .tag_cache(tag_cache));
    
    data_cache u5(.clk(clk),
    .index(index),
    .cache_data_we(cache_data_we),
    .cache_data_in(main_mem_o),
    .cache_data_o(cache_data_o));
    
    word_mux u6(.data_in(cache_data_o),
    .offset(offset),
    .word_data_o(data_o));
    
    main_memory u7(.clk(clk),.rst(rst),
    .cpu_addr(cpu_addr[31:2]),
    .mem_read(mem_read),
    .main_mem_o(main_mem_o),
    .mem_ready(mem_ready));
    
    fsm_cache u8(.clk(clk),.rst(rst),.cpu_req(cpu_req),
    .mem_ready(mem_ready),.hit(hit),
    .mem_read(mem_read),.cpu_ready(cpu_ready),
    .valid_we(valid_we),.tag_we(tag_we),.cache_data_we(cache_data_we));
    
endmodule
