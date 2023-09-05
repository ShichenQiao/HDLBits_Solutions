module top_module (
    input clk,
    input in, 
    output out);

    wire D;
    assign D = in ^ out;

    always_ff @(posedge clk)
        out <= D;
endmodule
