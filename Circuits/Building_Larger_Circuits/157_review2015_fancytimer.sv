module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    typedef enum reg [3:0] {IDLE, A, B, C, D, E, F, G, COUNT, DONE} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk)
        if(reset)
            state <= IDLE;
    	else
            state <= nxt_state;
    
    wire done_counting;

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

    wire shift_ena;
    reg [9:0] q;

    assign shift_ena = state == D | state == E | state == F | state == G;
    assign counting = state == COUNT;
    assign done = state == DONE;

    always_ff @(posedge clk)
        if(reset)
            count <= 4'hF;
        else if(shift_ena)
            count <= {count[2:0], data};
    	else if(|count & q == 10'd999)
            count <= count - 4'h1;
    
    always_ff @(posedge clk)
        if(state == G & nxt_state == COUNT)
            q <= '0;
    	else if(q == 10'd999)
            q <= '0;
    	else
            q <= q + 10'd1;
    
    assign done_counting = ~|count & q == 10'd999;

endmodule
