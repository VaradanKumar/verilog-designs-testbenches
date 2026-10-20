`timescale 1ns/1ps

// 4-bit modulo-16 up-counter with enable and asynchronous active-low reset.
module up_counter_4bit (
    input  wire      clk,
    input  wire      rst_n,
    input  wire      en,
    output reg [3:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'd0;
        else if (en)
            count <= count + 1'b1;
    end
endmodule
