module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    typedef enum reg [3:0] {IDLE, A, B, C, D, E, F, DISC, FLAG, ERR} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk)
        if(reset)
            state <= IDLE;
    	else
            state <= nxt_state;
    
    always_comb begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case(state)
            IDLE: nxt_state = in ? A : IDLE;
            A: nxt_state = in ? B : IDLE;
            B: nxt_state = in ? C : IDLE;
            C: nxt_state = in ? D : IDLE;
            D: nxt_state = in ? E : IDLE;
            E: nxt_state = in ? F : DISC;
            DISC: begin
                nxt_state = in ? A : IDLE;
                disc = 1'b1;
            end
            F: nxt_state = in ? ERR : FLAG;
            ERR: begin
                nxt_state = in ? ERR : IDLE;
                err = 1'b1;
            end
            FLAG: begin
                nxt_state = in ? A : IDLE;
                flag = 1'b1;
            end
        endcase
    end
endmodule
