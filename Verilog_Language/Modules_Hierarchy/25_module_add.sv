module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire ci;
    wire [15:0] sumu, suml;
    add16 il(a[15:0], b[15:0], 1'b0, suml, ci);
    add16 iu(a[31:16], b[31:16], ci, sumu);
    assign sum = {sumu, suml};
endmodule