module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    typedef enum reg [1:0] {IDLE, ZERO, ONE} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk, negedge aresetn)
        if(!aresetn)
            state <= IDLE;
    	else
            state <= nxt_state;
    
    always_comb begin
        z = 1'b0;
        
        case(state)
            IDLE: nxt_state = x ? ZERO : IDLE;
            ZERO: nxt_state = x ? ZERO : ONE;
            ONE: begin
                z = x;
                nxt_state = x ? ZERO : IDLE;
            end
        endcase
    end
    

endmodule
