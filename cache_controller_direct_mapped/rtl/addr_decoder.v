`timescale 1ns / 1ps

module addr_decoder(
    input [31:0] cpu_addr,
    output [25:0] tag_cpu,
    output [3:0] index,
    output [1:0] offset
    );
    
    assign tag_cpu=cpu_addr[31:6];
    assign index=cpu_addr[5:2];
    assign offset=cpu_addr[1:0];
    
endmodule
