`timescale 1ns/1ps

module tb_priority_encoder_8to3;
    reg  [7:0] in;
    wire [2:0] code;
    wire       valid;
    integer i;
    integer j;
    integer expected;
    integer errors;

    priority_encoder_8to3 dut (.in(in), .code(code), .valid(valid));

    initial begin
        errors = 0;
        for (i = 0; i < 256; i = i + 1) begin
            in = i[7:0];
            expected = 0;
            for (j = 0; j < 8; j = j + 1)
                if (in[j]) expected = j;
            #1;
            if (valid !== (i != 0) || code !== expected[2:0]) begin
                $display("FAIL priority_encoder: in=%b valid=%b code=%b expected_valid=%b expected_code=%0d", in, valid, code, (i != 0), expected);
                errors = errors + 1;
            end
        end
        if (errors == 0) $display("PASS tb_priority_encoder_8to3: all 256 input combinations passed.");
        else             $display("FAIL tb_priority_encoder_8to3: %0d errors.", errors);
        $finish;
    end
endmodule
