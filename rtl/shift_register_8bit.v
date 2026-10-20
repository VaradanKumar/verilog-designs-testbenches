`timescale 1ns/1ps

// 8-bit serial-in shift register with asynchronous active-low reset and enable.
// When enabled, data shifts toward bit 7 and serial_in enters bit 0.
module shift_register_8bit (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       en,
    input  wire       serial_in,
    output reg  [7:0] q
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 8'b0;
        else if (en)
            q <= {q[6:0], serial_in};
    end
endmodule
