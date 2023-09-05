module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire [2:0]c;
    bcd_fadd ia[3:0] (a, b, {c, cin}, {cout, c}, sum);
endmodule
