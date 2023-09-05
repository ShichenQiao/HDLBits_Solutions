module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 

    always_ff @(posedge clk)
        if(reset)
            q <= 5'h01;
    	else
            q <= {1'b0 ^ q[0], q[4], q[3] ^ q[0], q[2:1]};
endmodule
