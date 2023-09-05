module top_module (
    input clk,
    input a,
    output q );

    always_ff @(posedge clk)
        q <= ~a;
endmodule
