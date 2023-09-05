module top_module ();
    reg clk, reset, t, q;
    tff iDUT(clk, reset, t, q);
    
    initial begin
        clk = 1'b0;
        reset = 1'b1;
        t = 1'b0;
        @(negedge clk) t = 1'b1;
        reset = 1'b0;
    end
    
    always
        #5 clk = ~clk;
endmodule
