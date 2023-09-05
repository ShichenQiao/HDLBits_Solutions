module top_module (
    input clk,
    input reset,
    output [3:0] q);

    always @(posedge clk)
        if(reset)
            q <= 4'h1;
    	else if(q == 10)
            q <= 4'h1;
    	else
            q <= q + 1;
endmodule
