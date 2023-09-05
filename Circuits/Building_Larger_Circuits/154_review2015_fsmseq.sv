module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    typedef enum reg [2:0] {IDLE, A, B, C, D} state_t;
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
            D: nxt_state = D;
            default: nxt_state = IDLE;
        endcase
    
    assign start_shifting = state == D;
endmodule
