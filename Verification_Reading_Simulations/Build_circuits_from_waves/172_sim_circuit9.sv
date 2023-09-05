module top_module (
    input clk,
    input a,
    output [3:0] q );

    always_ff @(posedge clk)
        if(a)
            q <= 4'h4;
        else if(q == 4'h6)
            q <= 4'h0;
        else
            q <= q + 4'h1;
endmodule
