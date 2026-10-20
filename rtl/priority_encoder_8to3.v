`timescale 1ns/1ps

// 8-to-3 priority encoder. Bit 7 has the highest priority; bit 0 has the lowest.
module priority_encoder_8to3 (
    input  wire [7:0] in,
    output reg  [2:0] code,
    output wire       valid
);
    assign valid = |in;

    always @* begin
        if      (in[7]) code = 3'd7;
        else if (in[6]) code = 3'd6;
        else if (in[5]) code = 3'd5;
        else if (in[4]) code = 3'd4;
        else if (in[3]) code = 3'd3;
        else if (in[2]) code = 3'd2;
        else if (in[1]) code = 3'd1;
        else            code = 3'd0;
    end
endmodule
