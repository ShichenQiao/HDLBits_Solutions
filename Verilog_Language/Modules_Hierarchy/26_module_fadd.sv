module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire c;
    add16 il(a[15:0], b[15:0], 0, sum[15:0], c);
    add16 iu(a[31:16], b[31:16], c, sum[31:16]);
endmodule

module add1 ( input a, input b, input cin, output sum, output cout );
// Full adder module here
    assign sum = a ^ b ^ cin;
    assign cout = (b & cin) | (a & (b | cin));
endmodule