`timescale 1ns / 1ps

module cache_tb(

    );
    reg clk,rst;
    reg [31:0] cpu_addr;
    reg cpu_req;
    wire cpu_ready;
    wire [31:0] data_o;
    
    cache_top dut(.clk(clk),.rst(rst),
    .cpu_addr(cpu_addr),
    .cpu_req(cpu_req),
    .cpu_ready(cpu_ready),
    .data_o(data_o));
    
    always #5 clk=~clk;
    
    initial begin
    $monitor("Time=%0t,cpu_req=%b,cpu_addr=%b,cpu_ready=%b,data_o=%b ,mem_read=%b,mem_ready=%b",
        $time,cpu_req,cpu_addr,cpu_ready,data_o,dut.mem_read,dut.mem_ready);
        clk=0;
        rst=1;
        #2
        rst=0;
        
        #8
        rst=1;
        //miss
        cpu_req=1;
        cpu_addr=32'b00000000000000000000000000000000;
        #10 cpu_req=0;
        
        
        #100;
        //miss
        #10 cpu_req=1;
        cpu_addr=32'b00000000000000000000000000000100;
        #10 cpu_req=0;
        
        #100   //240
        
        //hit
        #10 cpu_req=1;
        cpu_addr=32'b00000000000000000000000000000000;
        #10 cpu_req=0;
        
        //hit
        #20 cpu_req=1;
        cpu_addr=32'b00000000000000000000000000000100;
        #10 cpu_req=0;
        
        #100
        $finish;
        
        
    end
endmodule
