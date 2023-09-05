module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q ); 

    reg [15:0][15:0] q2d, q_nxt;

    always_ff @(posedge clk) begin
        for(int i = 0; i < 16; i = i + 1)
            for(int j = 0; j < 16; j = j + 1)
                q2d[i][j] <= load ? data[i * 16 + j] : q_nxt[i][j];
        q <= load ? data : q_nxt;
    end
    
    int n;
    always_comb begin
        for(int i = 0; i < 16; i = i + 1)
            for(int j = 0; j < 16; j = j + 1) begin
                n = q2d[(i + 15) % 16][(j + 15) % 16] + 
                    q2d[i][(j + 15) % 16] +
                    q2d[(i + 1) % 16][(j + 15) % 16] +
                    q2d[(i + 15) % 16][j] +
                    q2d[(i + 1) % 16][j] +
                    q2d[(i + 15) % 16][(j + 1) % 16] +
                    q2d[i][(j + 1) % 16] +
                    q2d[(i + 1) % 16][(j + 1) % 16];
                q_nxt[i][j] = n != 2 ? n == 3 : q2d[i][j];
            end
    end
        
endmodule
