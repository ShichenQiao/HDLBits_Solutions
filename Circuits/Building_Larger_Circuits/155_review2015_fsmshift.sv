module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    reg [2:0] cnt;
    always_ff @(posedge clk)
        if(reset)
            cnt <= 3'b000;
    	else if(!cnt[2])
            cnt <= cnt + 3'b001;
    
    assign shift_ena = !cnt[2];
endmodule
