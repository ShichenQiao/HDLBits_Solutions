module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    edge_dect id[7:0](clk, in, pedge);
endmodule

module edge_dect (
    input clk,
    input in,
    output pedge
);
    wire in_ff;
    always_ff @(posedge clk)
        in_ff <= in;

    always_ff @(posedge clk)
        pedge <= in & !in_ff;
endmodule