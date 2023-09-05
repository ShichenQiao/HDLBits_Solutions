module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    always_ff @(posedge clk) begin
        if(reset) begin
       		hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;
        end
        else if(ena) begin
            if(ss[3] && ss[0]) begin
                ss[3:0] <= 4'h0;
                if(ss[6] && ss[4]) begin
                    ss[6:4] <= 4'h0;
                    if(mm[3] && mm[0]) begin
                        mm[3:0] <= 4'h0;
                        if(mm[6] && mm[4]) begin
                            mm[6:4] <= 4'h0;
                            if(hh == 8'h11) begin
                                hh <= 8'h12;
                                pm <= !pm;
                            end
                            else if(hh == 8'h12)
                                hh <= 8'h01;
                            else if(hh == 8'h09)
                                hh <= 8'h10;
                            else
                                hh[3:0] <= hh[3:0] + 4'h1;
                        end
                        else
                            mm[6:4] <= mm[6:4] + 3'h1;
                    end
                    else
                        mm[3:0] <= mm[3:0] + 4'h1;
                end
                else
                    ss[6:4] <= ss[6:4] + 3'h1;
            end
            else
                ss[3:0] <= ss[3:0] + 4'h1;
        end
    end
endmodule
