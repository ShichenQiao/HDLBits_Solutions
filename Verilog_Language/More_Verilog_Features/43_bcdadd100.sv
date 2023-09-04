module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [98:0] c;
    bcd_fadd iadd[99:0](a, b, {c, cin}, {cout, c}, sum);

endmodule
