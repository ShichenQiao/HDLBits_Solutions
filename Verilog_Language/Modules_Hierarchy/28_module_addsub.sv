module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0]bin;
    assign bin = b ^ {32{sub}};
    wire c;
    add16 i1(a[15:0], bin[15:0], sub, sum[15:0], c);
    add16 i2(a[31:16], bin[31:16], c, sum[31:16]);
endmodule
