`timescale 1ns/1ps

// 8-to-3 one-hot encoder. Exactly one input bit must be asserted for valid=1.
module encoder_8to3 (
    input  wire [7:0] onehot,
    output reg  [2:0] code,
    output reg        valid
);
    always @* begin
        code  = 3'b000;
        valid = 1'b1;
        case (onehot)
            8'b00000001: code = 3'd0;
            8'b00000010: code = 3'd1;
            8'b00000100: code = 3'd2;
            8'b00001000: code = 3'd3;
            8'b00010000: code = 3'd4;
            8'b00100000: code = 3'd5;
            8'b01000000: code = 3'd6;
            8'b10000000: code = 3'd7;
            default: begin
                code  = 3'b000;
                valid = 1'b0;
            end
        endcase
    end
endmodule
