module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    typedef enum reg [1:0] {IDLE, ONE, ZERO} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk, posedge areset)
        if(areset)
            state <= IDLE;
    	else
            state <= nxt_state;
    
    always_comb begin
        case(state)
            IDLE: begin
                z = 0;
                nxt_state = x ? ONE : IDLE;
            end
            ONE: begin
                z = 1;
                nxt_state = x ? ZERO : ONE;
            end
            ZERO: begin
                z = 0;
                nxt_state = x ? ZERO : ONE;
            end
        endcase
    end
endmodule
