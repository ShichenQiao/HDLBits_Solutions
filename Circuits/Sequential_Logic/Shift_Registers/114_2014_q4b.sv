module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    MUXDFF im[3:0] (KEY[0], {KEY[3], LEDR[3:1]}, SW, KEY[1], KEY[2], LEDR);
endmodule

module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
    always_ff @(posedge clk)
        Q <= L ? R : E ? w : Q;
endmodule
