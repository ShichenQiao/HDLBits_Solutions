module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    typedef enum reg[1:0] {IDLE, TRAN, FAIL} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk)
        if(reset)
            state <= IDLE;
    	else
            state <= nxt_state;
    
    reg [3:0] cnt;
    reg rst_cnt;
    always_ff @(posedge clk)
        if(rst_cnt)
            cnt <= 4'h9;
    	else
            cnt <= cnt - 1;
    
    reg set_done;

    always_comb begin
        nxt_state = state;
        rst_cnt = 1'b0;
        set_done = 1'b0;
        
        case(state)
            IDLE:
                if(!in) begin
                    rst_cnt = 1'b1;
                    nxt_state = TRAN;
                end
            TRAN:
                if(~|cnt)
                    if(in) begin
                        set_done = 1'b1;
                        nxt_state = IDLE;
                    end
            	    else
                        nxt_state = FAIL;
            FAIL: if(in) nxt_state = IDLE;
        endcase
    end

    reg [9:0] buffer;
    always_ff @(posedge clk)
        buffer <= {in, buffer[9:1]};
    assign out_byte = done? buffer[7:0] : 8'hXX;

    // New: Add parity checking.
    wire odd;
    parity ip (clk, rst_cnt, in, odd);
	
    always_ff @(posedge clk)
        if(set_done & odd)
            done <= 1'b1;
    	else
            done <= 1'b0;

endmodule
