module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    reg state, nxt_state;
    
    always_ff @(posedge clk)
        if(reset)
            state <= 1'b0;
    	else
            state <= nxt_state;
    
    reg [1:0] cnt;
    wire rst_cnt;
    
    always_ff @(posedge clk)
        if(rst_cnt)
            cnt <= 2'b10;
    	else if(~|cnt)
            cnt <= 2'b10;
    	else
            cnt <= cnt - 2'b01;
    
    reg [1:0] buffer;
    
    always_ff @(posedge clk)
        buffer <= {buffer[0], w};
    
    always_comb begin
        rst_cnt = 1'b0;
        nxt_state = state;
        
        case(state)
            1'b0: 
                if(s) begin
                    rst_cnt = 1'b1;
                    nxt_state = 1'b1;
                end
            1'b1: begin
                nxt_state = state;
            end
        endcase
    end
    
    always_ff @(posedge clk)
        if(reset)
            z <= 1'b0;
    	else if(!state)
            z <= 1'b0;
    	else if((~|cnt) & (((buffer == 2'b01) & w) | ((buffer == 2'b10) & w) | ((buffer == 2'b11) & !w)))
            z <= 1'b1;
    	else
            z <= 1'b0;
endmodule
