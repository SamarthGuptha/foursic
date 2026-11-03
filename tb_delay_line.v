`timescale 1ns / 1ps

module tb_delay_line;
    //tb signals

    reg clk = 0;
    reg rst = 1;
    reg signed [7:0] x_in = 8'sd0;
    wire signed [15:0] s1;
    wire signed [15:0] s2;

    delay_line uut (
        .clk (clk),
        .rst (rst),
        .x_in (x_in),
        .s1 (s1),
        .s2 (s2)
    );
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dline_wave.vcd");
        $dumpvars(0, tb_delay_line);

        $display("Shift reg sim");
        $monitor("Time = %3t ns | rst = %b | x_in = %4d | s1 = %4d | s2 = %4d", $time, rst, x_in, s1, s2);
        #10;
        rst = 0;
        x_in = 8'sd10; #10;
        x_in = 8'sd0; #10;
        x_in = -8'sd10; #10;
        x_in  = 8'sd0; #10;


        x_in = 8'sd10; #10;
        x_in = 8'sd0; #10;
        x_in = -8'sd10; #10;
        x_in = 8'sd0; #10;

        #10;
        $display("fin");
        $finish;
    end

endmodule