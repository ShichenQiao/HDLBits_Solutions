module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    typedef enum reg [2:0] {A, B, C, D, E, F} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk)
        if(reset)
            state <= A;
    	else
            state <= nxt_state;
    
    always_comb begin
        case(state)
            A: nxt_state = w ? B : A;
            B: nxt_state = w ? C : D;
            C: nxt_state = w ? E : D;
            D: nxt_state = w ? F : A;
            E: nxt_state = w ? E : D;
            F: nxt_state = w ? C : D;
            default: nxt_state = A;
        endcase
    end
    
    assign z = state == E || state == F;
endmodule
