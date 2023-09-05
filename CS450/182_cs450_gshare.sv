module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    reg [1:0] PHT [127:0];

    always_ff @(posedge clk, posedge areset)
        if(areset) begin
            predict_history <= '0;
            for(int i = 0; i < 128; i = i + 1)
                PHT[i] <= 2'b01;
        end
    	else begin
            // training: update PHT saturation counters
            if(train_valid)
                if(train_taken)
                    PHT[train_history ^ train_pc] = PHT[train_history ^ train_pc] == 2'b11 ? 2'b11 : PHT[train_history ^ train_pc] + 2'b01;
            	else
                    PHT[train_history ^ train_pc] = PHT[train_history ^ train_pc] == 2'b00 ? 2'b00 : PHT[train_history ^ train_pc] - 2'b01;
                    
            // predicting: misprediction take higher priority than prediction
            if(train_valid & train_mispredicted)
            	predict_history <= {train_history[5:0], train_taken};
       	    else if(predict_valid)
                predict_history <= {predict_history[5:0], predict_taken};
        end
    
    assign predict_taken = PHT[predict_pc ^ predict_history][1];
    
endmodule
