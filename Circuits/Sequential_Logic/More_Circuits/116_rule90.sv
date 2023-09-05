module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 

    wire [513:0] q_nxt;
    assign q_nxt = {q, 2'b00} ^ {2'b00, q};
    always_ff @(posedge clk)
        if(load)
            q <= data;
    	else
            q <= q_nxt[512:1];
endmodule
