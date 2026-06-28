`timescale 1ns / 1ps

module word_mux(
    input [127:0] data_in,
    input [1:0] offset,
    output reg [31:0] word_data_o
    );
    always@(*)begin
        case(offset)
        2'b11:word_data_o=data_in[127:96];
        2'b10:word_data_o=data_in[95:64];
        2'b01:word_data_o=data_in[63:32];
        2'b00:word_data_o=data_in[31:0];
        endcase
    end
endmodule
