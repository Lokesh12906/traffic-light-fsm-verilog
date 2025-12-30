module trafficlight(clk,rst,pdst,light);
    input rst,clk,pdst;
    output reg [2:0] light;
    parameter RED=2'b00;
    parameter YELLOW=2'b01;
    parameter GREEN=2'b10;
    parameter BLINK=2'b11;
    parameter RED_TIME=3'd7;
    parameter YELLOW_TIME=3'd3;
    parameter GREEN_TIME=3'd6;
    parameter BLINK_TIME=3'd2;
    parameter MIN_GREEN=3'd3;
    reg [1:0] PS,NS;  //present state and next state
    reg [3:0] timer;
    reg [3:0] red_time;
    reg pdst_latched;
    reg [2:0] count;
    reg clk_en;

    always @(posedge clk or posedge rst)  //clock divider
        begin
           if (rst) begin
              count<=3'd0;
              clk_en<=0;
           end
           else if (count==3'd5)
             begin
                count<=3'd0;
                clk_en<=1'b1;
             end
           else begin
              count<=count+3'd1;
              clk_en<=1'b0;
           end
        end
    always @(posedge clk or posedge rst) //FSM state register
        begin
           if (rst) begin
              PS<=RED;
           end
          else if (clk_en)
            PS<=NS;
        end
    always @(posedge clk or posedge rst)  //timer logic
     begin
        if (rst)
          timer<=4'd0;
        else if (clk_en)
           if (PS==NS)
            begin
             timer<=timer+4'd1;
            end
           else
             timer<=4'd0;
     end
    always @(posedge clk or posedge rst)  //pedestrian input
        begin
            if (rst) 
                pdst_latched<=0;
            else if (pdst)
               pdst_latched<=1'b1;
            else if (clk_en&& PS==RED)
                pdst_latched<=0;
            else if (clk_en && PS==YELLOW && NS==RED)
               pdst_latched<=1'b0;
            end
    always @(posedge clk or posedge rst)  //red time logic for pedestrian input
       begin
           if (rst)
              red_time<=RED_TIME;
           else if (clk_en && PS==YELLOW && NS==RED)
              red_time<=pdst_latched ? RED_TIME+3'D3 : RED_TIME;
       end
    always @(*)  //next state logic     
         begin
            NS=PS;
            case(PS)
               RED :
                 begin
                    if (timer==red_time-1)
                        NS=GREEN;
                    else
                      NS=RED;
                 end
               GREEN:
                  begin
                     if (pdst_latched && timer>=MIN_GREEN-1)
                        NS=BLINK;
                    else if(timer==GREEN_TIME-1) 
                        NS=BLINK;
                    else 
                      NS=GREEN;
                  end
               YELLOW:
                   begin
                    if (timer==YELLOW_TIME-1)
                       NS=RED;
                    else
                       NS=YELLOW;
                   end
                   
               BLINK:
                   begin
                    if(timer==BLINK_TIME-1)
                       NS=YELLOW;
                    else
                       NS=BLINK;
                   end
                default: NS=RED;
            endcase

        end    
    always @(*)  //output logic
         begin
            case(PS)
                RED: light=3'b100;
                YELLOW:light=3'b010;
                GREEN:light=3'b001;
                BLINK:light=timer[0]?3'b001:3'b000;
                default:light=3'b100;
            endcase
         end
endmodule

