module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire sel;
    wire [15:0] sum1, sum2;
    add16 i1(a[15:0], b[15:0], 0, sum[15:0], sel);
    add16 i2(a[31:16], b[31:16], 0, sum1);
    add16 i3(a[31:16], b[31:16], 1, sum2);
    assign sum[31:16] = sel ? sum2 : sum1;
endmodule
