module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    wire [511:0] q_nxt;
    assign q_nxt[0] = q[0];
    assign q_nxt[511] = q[511] | q[510];
    always_comb
        for(int i = 1; i < 511; i = i + 1)
            q_nxt[i] = q[i] ? !(q[i + 1] & q[i - 1]) : q[i - 1];

    always_ff @(posedge clk)
        if(load)
            q <= data;
    	else
            q <= q_nxt;
endmodule
