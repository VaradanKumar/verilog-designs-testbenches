`timescale 1ns/1ps

// Moore FSM that detects the serial pattern 101. Overlapping patterns are allowed.
module sequence_detector_101 (
    input  wire clk,
    input  wire rst_n,
    input  wire serial_in,
    output wire detected
);
    localparam [1:0] IDLE    = 2'b00;
    localparam [1:0] GOT_1   = 2'b01;
    localparam [1:0] GOT_10  = 2'b10;
    localparam [1:0] DETECT  = 2'b11;

    reg [1:0] state;
    reg [1:0] next_state;

    assign detected = (state == DETECT);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @* begin
        next_state = IDLE;
        case (state)
            IDLE: begin
                if (serial_in) next_state = GOT_1;
                else           next_state = IDLE;
            end
            GOT_1: begin
                if (serial_in) next_state = GOT_1;
                else           next_state = GOT_10;
            end
            GOT_10: begin
                if (serial_in) next_state = DETECT;
                else           next_state = IDLE;
            end
            DETECT: begin
                // Preserve the longest suffix that can start another "101" match.
                if (serial_in) next_state = GOT_1;
                else           next_state = GOT_10;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
