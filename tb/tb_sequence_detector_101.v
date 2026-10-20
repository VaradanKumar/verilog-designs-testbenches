`timescale 1ns/1ps

module tb_sequence_detector_101;
    reg clk;
    reg rst_n;
    reg serial_in;
    wire detected;
    integer errors;

    sequence_detector_101 dut (
        .clk(clk), .rst_n(rst_n), .serial_in(serial_in), .detected(detected)
    );
    always #5 clk = ~clk;

    task send_bit_and_check;
        input bit_value;
        input expected_detected;
        begin
            @(negedge clk);
            serial_in = bit_value;
            @(posedge clk);
            #1;
            if (detected !== expected_detected) begin
                $display("FAIL sequence_detector_101: input=%b detected=%b expected=%b", bit_value, detected, expected_detected);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        clk = 0;
        rst_n = 0;
        serial_in = 0;
        errors = 0;
        #12;
        @(negedge clk);
        rst_n = 1;

        // 1 0 1 produces a match; the following 1 0 1 produces another match.
        send_bit_and_check(1'b1, 1'b0);
        send_bit_and_check(1'b0, 1'b0);
        send_bit_and_check(1'b1, 1'b1);
        send_bit_and_check(1'b1, 1'b0);
        send_bit_and_check(1'b0, 1'b0);
        send_bit_and_check(1'b1, 1'b1);

        if (errors == 0) $display("PASS tb_sequence_detector_101: pattern detection and overlap checks passed.");
        else             $display("FAIL tb_sequence_detector_101: %0d errors.", errors);
        $finish;
    end
endmodule
