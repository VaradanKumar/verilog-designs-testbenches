`timescale 1ns/1ps

module tb_shift_register_8bit;
    reg clk;
    reg rst_n;
    reg en;
    reg serial_in;
    wire [7:0] q;
    integer errors;

    shift_register_8bit dut (.clk(clk), .rst_n(rst_n), .en(en), .serial_in(serial_in), .q(q));
    always #5 clk = ~clk;

    task shift_and_check;
        input bit_value;
        input [7:0] expected;
        begin
            @(negedge clk);
            serial_in = bit_value;
            @(posedge clk);
            #1;
            if (q !== expected) begin
                $display("FAIL shift_register: serial_in=%b q=%b expected=%b", bit_value, q, expected);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        clk = 0;
        rst_n = 0;
        en = 0;
        serial_in = 0;
        errors = 0;
        #12;
        if (q !== 8'b0) begin
            $display("FAIL shift_register: reset value q=%b expected=00000000", q);
            errors = errors + 1;
        end
        @(negedge clk);
        rst_n = 1;
        en = 1;
        shift_and_check(1'b1, 8'b00000001);
        shift_and_check(1'b0, 8'b00000010);
        shift_and_check(1'b1, 8'b00000101);
        shift_and_check(1'b1, 8'b00001011);
        @(negedge clk);
        en = 0;
        serial_in = 1'b0;
        @(posedge clk);
        #1;
        if (q !== 8'b00001011) begin
            $display("FAIL shift_register: q changed while enable was low: q=%b", q);
            errors = errors + 1;
        end
        if (errors == 0) $display("PASS tb_shift_register_8bit: shift, reset, and enable checks passed.");
        else             $display("FAIL tb_shift_register_8bit: %0d errors.", errors);
        $finish;
    end
endmodule
