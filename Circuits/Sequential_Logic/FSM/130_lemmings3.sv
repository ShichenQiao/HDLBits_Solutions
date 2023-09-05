module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    typedef enum reg {L, R} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk, posedge areset)
        if(areset)
            aaah <= 1'b0;
    	else
            aaah <= !ground;

    always_ff @(posedge clk, posedge areset)
        if(areset)
            digging <= 1'b0;
    	else if(!ground)
            digging <= 1'b0;
    	else if(dig & ground & !aaah)
            digging <= 1'b1;

    always_ff @(posedge clk, posedge areset)
        if(areset)
            state <= L;
    	else
            state <= nxt_state;
    
    always_comb begin
        nxt_state = state;
        case(state)
            L: if(ground & !aaah & bump_left & !digging & !dig) nxt_state = R;
            R: if(ground & !aaah & bump_right & !digging & !dig) nxt_state = L;
        endcase
    end
    
    assign walk_left = !state & !aaah & !digging;
    assign walk_right = state & !aaah & !digging;
    
endmodule
