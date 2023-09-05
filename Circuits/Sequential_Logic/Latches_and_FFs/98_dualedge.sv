module top_module (
    input clk,
    input d,
    output q
);

    wire p, n;
    always_ff @(posedge clk)
        p <= d;
    always_ff @(negedge clk)
        n <= d;
    assign q = clk ? p : n;
endmodule
