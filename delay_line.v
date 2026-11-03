module delay_line (
    input wire clk,
    input wire rst,
    input wire signed [7:0] x_in,
    output reg signed [15:0] s1,
    output reg signed [15:0] s2
);

    always @(posedge clk) begin
        if (rst) begin
            s1 <= 16'sd0;
            s2 <= 16'sd0;
        end else begin
            s1 <= x_in;
            s2 <= s1;
        end
    end

endmodule