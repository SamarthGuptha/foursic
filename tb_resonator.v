`timescale 1ns / 1ps;
module tb_resonator;
    reg clk = 0;
    reg rst = 1;
    reg signed [7:0] x_in = 0;
    wire signed [15:0] s1;
    wire signed [15:0] s2;

    integer i;

    resonator uut(
        .clk (clk),
        .rst (rst),
        .x_in(x_in),
        .s2(s2),
        .s1(s1)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("resonator_wave.vcd");
        $dumpvars(0, tb_resonator);
        $display("T1: Matching 4 tick wave ");
        $monitor("Time = %3t ns | rst=%b | x_in = %4d | s1 = %5d | s2 = %5d", $time, rst, x_in, s1, s2);
        #10 rst = 0;
        for (i=0; i<6; i=i+1) begin
            x_in = 8'sd10; #10;
            x_in = 8'sd0; #10;
            x_in = -8'sd10; #10;
            x_in = 8'sd0; #10;
        end

        $display("T2: Wrong freq");
        rst=1; x_in = 8'sd0; #10;
        rst=0;

        for (i = 0; i<4; i= i+1) begin //4 cycles rapid 2tick
            x_in = 8'sd10; #10;
            x_in = -8'sd10; #10;
        end

        for (i=0; i<8; i = i+1) begin //feeding const dc value
            x_in = 9'sd10; #10;
        end
        $finish;
    end

endmodule