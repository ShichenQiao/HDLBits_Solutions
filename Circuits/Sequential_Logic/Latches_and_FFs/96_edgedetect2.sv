module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    edge_dect id[7:0](clk, in, anyedge);
endmodule

module edge_dect (
    input clk,
    input in,
    output anyedge
);
    wire in_ff;
    always_ff @(posedge clk)
        in_ff <= in;

    always_ff @(posedge clk)
        anyedge <= in ^ in_ff;
endmodule
