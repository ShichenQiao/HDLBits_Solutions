module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 

    always_ff @(posedge clk)
        if(load)
            q <= data;
    	else if(^ena)
            q <= ena[0] ? {q[0], q[99:1]} : {q[98:0], q[99]};
    
endmodule
