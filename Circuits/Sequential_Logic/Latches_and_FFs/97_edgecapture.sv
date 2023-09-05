module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    edge_dect id[31:0](clk, reset, in, out);
endmodule

module edge_dect (
    input clk,
    input reset,
    input in,
    output nedge
);
    wire in_ff;
    always_ff @(posedge clk)
        in_ff <= in;

    always_ff @(posedge clk)
        if(reset)
            nedge <= 1'b0;
        else if(!in & in_ff)
            nedge <= 1'b1;
endmodule
