module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);

    always_ff @(posedge clk, posedge areset)
        if(areset)
            q <= 8'h00;
    	else
            q <= d;
endmodule
