module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    fulladd iadd[99:0](a, b, {cout[98:0], cin}, cout, sum);
endmodule

module fulladd(input a, input b, input cin, output cout, output sum);
    assign sum = a ^ b ^ cin;
    assign cout = (b & cin) | a & (b | cin);
endmodule