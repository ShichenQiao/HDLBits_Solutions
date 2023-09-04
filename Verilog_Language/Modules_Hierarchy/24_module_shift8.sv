module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] a, b, c;
    my_dff8 i1 (clk, d, a);
    my_dff8 i2 (clk, a, b);
    my_dff8 i3 (clk, b, c);
    assign q = sel[1] ? sel[0] ? c : b : sel[0] ? a : d;

endmodule