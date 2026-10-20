`timescale 1ns/1ps

module tb_encoder_8to3;
    reg  [7:0] onehot;
    wire [2:0] code;
    wire       valid;
    integer i;
    integer errors;

    encoder_8to3 dut (.onehot(onehot), .code(code), .valid(valid));

    initial begin
        errors = 0;
        onehot = 8'b0;
        for (i = 0; i < 8; i = i + 1) begin
            onehot = (8'b00000001 << i);
            #1;
            if (valid !== 1'b1 || code !== i[2:0]) begin
                $display("FAIL encoder_8to3: onehot=%b valid=%b code=%b expected=%0d", onehot, valid, code, i);
                errors = errors + 1;
            end
        end
        onehot = 8'b00000000;
        #1;
        if (valid !== 1'b0) begin
            $display("FAIL encoder_8to3: zero input should be invalid.");
            errors = errors + 1;
        end
        onehot = 8'b00000101;
        #1;
        if (valid !== 1'b0) begin
            $display("FAIL encoder_8to3: multi-hot input should be invalid.");
            errors = errors + 1;
        end
        if (errors == 0) $display("PASS tb_encoder_8to3: one-hot, zero, and multi-hot cases passed.");
        else             $display("FAIL tb_encoder_8to3: %0d errors.", errors);
        $finish;
    end
endmodule
