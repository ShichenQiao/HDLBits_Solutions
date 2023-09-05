module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    typedef enum reg [1:0] {AS3, S2S3, S1S2, BS1} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk)
        if(reset)
            state <= BS1;
    	else
    		state <= nxt_state;
    
    reg set_dfr, clr_dfr;
    always_ff @(posedge clk)
        if(reset)
            dfr <= 1'b1;
        else if(set_dfr)
            dfr <= 1'b1;
        else if(clr_dfr)
            dfr <= 1'b0;

    always_comb begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        set_dfr = 1'b0;
        clr_dfr = 1'b0;
        nxt_state =	state;
        
        case(state)
            AS3: begin
                if(!s[3]) begin
                    set_dfr = 1'b1;
                    nxt_state = S2S3;
                end
            end
            S2S3: begin
                if(s[3]) begin
                    clr_dfr = 1'b1;
                    nxt_state = AS3;
                end
                if(!s[2]) begin
                    set_dfr = 1'b1;
                    nxt_state = S1S2;
                end
                fr1 = 1'b1;
            end
            S1S2: begin
                if(s[2]) begin
                    clr_dfr = 1'b1;
                    nxt_state = S2S3;
                end
                if(!s[1]) begin
                    set_dfr = 1'b1;
                    nxt_state = BS1;
                end
                fr2 = 1'b1;
                fr1 = 1'b1;
            end
            BS1: begin
                if(s[1]) begin
                    clr_dfr = 1'b1;
                    nxt_state = S1S2;
                end
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
            end
        endcase
    end

endmodule
