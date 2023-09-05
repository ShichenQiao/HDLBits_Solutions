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

    typedef enum reg [2:0] {L, R, LD, RD, LF, RF, D} state_t;
    state_t state, nxt_state;
    always_ff @(posedge clk, posedge areset)
        if(areset)
            state <= L;
    	else
            state <= nxt_state;

    reg [5:0] fall;
    always_ff @(posedge clk, posedge areset)
        if(areset) begin
            fall <= 5'd20;
        end
    	else if(~|fall)
            fall <= 5'h00;
    	else if(!aaah)
            fall <= 5'd20;
    	else
            fall <= fall - 1;

    always_comb begin
        nxt_state = state;
        case(state)
            L: begin
                if(!ground)
                    nxt_state = LF;
                else if (dig)
                    nxt_state = LD;
                else if (bump_left)
                    nxt_state = R;
            end
            R: begin
                if(!ground)
                    nxt_state = RF;
                else if (dig)
                    nxt_state = RD;
                else if (bump_right)
                    nxt_state = L;
            end
            LD: begin
                if(!ground)
                    nxt_state = LF;
            end
            RD: begin
                if(!ground)
                    nxt_state = RF;
            end
            LF: begin
                if (ground)
                    if(~|fall)
                    	nxt_state = D;
                	else
                    	nxt_state = L;
            end
            RF: begin
                if (ground)
                    if(~|fall)
                    	nxt_state = D;
                	else
                    	nxt_state = R;
            end
            D: begin
                nxt_state = D; // died
            end
        endcase
    end
    
    assign walk_left = (state == L) & (state != D);
    assign walk_right = (state == R) & (state != D);
    assign aaah = ((state == LF) | (state == RF)) & (state != D);
    assign digging = ((state == LD) | (state == RD)) & (state != D);


endmodule
