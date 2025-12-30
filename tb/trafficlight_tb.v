`timescale 1ns/1ps

module trafficlight_tb;

    reg clk;
    reg rst;
    reg pdst;
    wire [2:0] light;

    trafficlight dut (
        .clk(clk),
        .rst(rst),
        .pdst(pdst),
        .light(light)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    initial begin
        $monitor(
            "T=%0t | rst=%b pdst=%b | light=%b",
            $time, rst, pdst, light
        );
    end

    initial begin

        $dumpfile("trafficlight.vcd");
        $dumpvars(0, trafficlight_tb);


        rst  = 1;
        pdst = 0;

        #20;
        rst = 0;

        #200;

        pdst = 1;
        #10;
        pdst = 0;


        #300;


        pdst = 1;
        #10;
        pdst = 0;

        #4000

        $finish;
    end

endmodule
