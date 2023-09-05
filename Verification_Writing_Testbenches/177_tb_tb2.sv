module top_module();

    reg clk, in, out;
    reg [2:0] s;
    q7 iDUT (clk, in, s, out);
    
    initial begin
        clk = 0;
        in = 0;
        s = 2;
        @(negedge clk) s = 6;
        @(negedge clk) s = 2;
        in = 1;
        @(negedge clk) s = 7;
        in = 0;
        @(negedge clk) s = 0;
        in = 1;
        repeat(3) @(negedge clk);
        in = 0;
    end
    
    always
        #5 clk = ~clk;
endmodule
