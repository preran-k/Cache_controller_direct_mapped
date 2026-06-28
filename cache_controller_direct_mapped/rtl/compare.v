`timescale 1ns / 1ps

module compare(
    input valid,
    input [25:0] tag_cpu,
    input [25:0] tag_cache,
    output hit
    );
    assign hit=(valid&&(tag_cpu==tag_cache));
endmodule
