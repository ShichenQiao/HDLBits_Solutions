module top_module (
    input clk,
    input j,
    input k,
    output Q); 

    always_ff @(posedge clk)
        Q <= j ^ k ? j : j ^ Q;
endmodule
