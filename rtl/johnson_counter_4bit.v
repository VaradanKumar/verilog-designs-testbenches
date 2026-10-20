`timescale 1ns/1ps

// 4-bit Johnson (twisted-ring) counter; produces 8 states in its normal cycle.
module johnson_counter_4bit (
    input  wire      clk,
    input  wire      rst_n,
    input  wire      en,
    output reg [3:0] q
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 4'b0000;
        else if (en)
            q <= {q[2:0], ~q[3]};
    end
endmodule
