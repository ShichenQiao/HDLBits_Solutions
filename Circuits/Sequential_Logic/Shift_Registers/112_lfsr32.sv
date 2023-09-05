module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 

    always_ff @(posedge clk)
        if(reset)
            q <= 32'h00000001;
    	else
            q <= {1'b0 ^ q[0], q[31:23], q[22] ^ q[0], q[21:3], q[2] ^ q[0], q[1] ^ q[0]};
    
endmodule
