module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    dc ic[3:0] (
        .clk(clk),
        .reset(reset),
        .en({ena[3:1], 1'b1}),
        .q(q)
    );

    assign ena[1] = q[3] & q[0];
    assign ena[2] = q[7] & q[4] & ena[1];
    assign ena[3] = q[11] & q[8] & ena[2] & ena[1];

endmodule

module dc (
    input clk,
    input reset,
    input en,
    output [3:0] q
);
    always_ff @(posedge clk)
        if(reset)
            q <= 4'h0;
        else if(en) begin
            if(q == 4'h9)
                q <= 4'h0;
            else
                q <= q + 4'h1;
        end
endmodule
