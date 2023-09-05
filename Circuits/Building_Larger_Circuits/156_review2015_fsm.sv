module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    typedef enum reg [3:0] {IDLE, A, B, C, D, E, F, G, COUNT, DONE} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk)
        if(reset)
            state <= IDLE;
    	else
            state <= nxt_state;
    
	always_comb
        case(state)
            IDLE: nxt_state = data ? A : IDLE;
            A: nxt_state = data ? B : IDLE;
            B: nxt_state = data ? B : C;
            C: nxt_state = data ? D : IDLE;
            D: nxt_state = E;
            E: nxt_state = F;
            F: nxt_state = G;
            G: nxt_state = COUNT;
            COUNT: nxt_state = done_counting ? DONE : COUNT;
            DONE: nxt_state = ack ? IDLE : DONE;
        endcase

    assign shift_ena = state == D | state == E | state == F | state == G;
    assign counting = state == COUNT;
    assign done = state == DONE;

endmodule
