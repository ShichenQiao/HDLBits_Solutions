module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    reg [1:0] state, nxt_state;
    
    always_ff @(posedge clk, posedge areset)
        if(areset)
            state <= 2'b01;
    	else
            state <= nxt_state;
    
    always_comb begin
        z = 1'b0;
        nxt_state = state;
        case (state)
            2'b01:
                if(x) begin
                    z = 1'b1;
                    nxt_state = 2'b10;
                end
            2'b10: z = !x;     
        endcase
    end
endmodule
