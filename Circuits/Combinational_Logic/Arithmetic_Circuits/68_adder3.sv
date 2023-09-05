module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

    fa ia[2:0](a, b, {cout[1:0], cin}, cout, sum);

endmodule

module fa( 
    input a, b, cin,
    output cout, sum );

    assign cout = (a & b) | (a & cin) | (b & cin);
    assign sum = a ^ b ^ cin;
endmodule