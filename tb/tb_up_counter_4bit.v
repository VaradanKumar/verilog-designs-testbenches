`timescale 1ns/1ps

module tb_up_counter_4bit;
    reg clk;
    reg rst_n;
    reg en;
    wire [3:0] count;
    integer i;
    integer errors;
    reg [3:0] expected;

    up_counter_4bit dut (.clk(clk), .rst_n(rst_n), .en(en), .count(count));
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        en = 0;
        errors = 0;
        expected = 0;
        #12;
        if (count !== 4'd0) begin
            $display("FAIL up_counter: reset count=%0d expected=0", count);
            errors = errors + 1;
        end
        @(negedge clk);
        rst_n = 1;
        en = 1;
        for (i = 0; i < 18; i = i + 1) begin
            @(posedge clk);
            #1;
            expected = expected + 1'b1;
            if (count !== expected) begin
                $display("FAIL up_counter: count=%0d expected=%0d", count, expected);
                errors = errors + 1;
            end
        end
        @(negedge clk);
        en = 0;
        expected = count;
        repeat (2) begin
            @(posedge clk);
            #1;
            if (count !== expected) begin
                $display("FAIL up_counter: count changed while enable was low.");
                errors = errors + 1;
            end
        end
        if (errors == 0) $display("PASS tb_up_counter_4bit: reset, count, wraparound, and enable checks passed.");
        else             $display("FAIL tb_up_counter_4bit: %0d errors.", errors);
        $finish;
    end
endmodule
