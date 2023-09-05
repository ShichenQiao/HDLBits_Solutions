module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

    reg [9:0] cnt;

    always_ff @(posedge clk)
        if(load)
            cnt <= data;
    	else if (|cnt)
            cnt <= cnt - 1;

    assign tc = ~|cnt;
endmodule
