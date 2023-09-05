module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    always_ff @(posedge clk)
        if(reset)
            q <= 4'h0;
    else if(slowena) begin
        if(q == 9)
            q <= 4'h0;
        else
            q <= q + 1;
    end
endmodule
