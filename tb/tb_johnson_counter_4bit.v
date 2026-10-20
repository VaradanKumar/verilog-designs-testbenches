`timescale 1ns/1ps

module tb_johnson_counter_4bit;
    reg clk;
    reg rst_n;
    reg en;
    wire [3:0] q;
    reg [3:0] expected;
    integer i;
    integer errors;

    johnson_counter_4bit dut (.clk(clk), .rst_n(rst_n), .en(en), .q(q));
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        en = 0;
        expected = 4'b0000;
        errors = 0;
        #12;
        if (q !== expected) begin
            $display("FAIL johnson_counter: reset q=%b expected=%b", q, expected);
            errors = errors + 1;
        end
        @(negedge clk);
        rst_n = 1;
        en = 1;
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            #1;
            expected = {expected[2:0], ~expected[3]};
            if (q !== expected) begin
                $display("FAIL johnson_counter: q=%b expected=%b", q, expected);
                errors = errors + 1;
            end
        end
        if (errors == 0) $display("PASS tb_johnson_counter_4bit: Johnson sequence and cycle checks passed.");
        else             $display("FAIL tb_johnson_counter_4bit: %0d errors.", errors);
        $finish;
    end
endmodule
