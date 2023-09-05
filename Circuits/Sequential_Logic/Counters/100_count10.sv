module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    always_ff @(posedge clk)
        if(reset)
            q <= '0;
    	else if(q == 4'h9)
            q <= '0;
    	else
            q <= q + 4'h1;
endmodule
