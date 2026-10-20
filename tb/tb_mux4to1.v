`timescale 1ns/1ps

module tb_mux4to1;
    reg  [3:0] d;
    reg  [1:0] sel;
    wire       y;
    integer i;
    integer j;
    integer errors;

    mux4to1 dut (.d(d), .sel(sel), .y(y));

    initial begin
        errors = 0;
        d = 4'b0000;
        sel = 2'b00;
        for (i = 0; i < 16; i = i + 1) begin
            d = i[3:0];
            for (j = 0; j < 4; j = j + 1) begin
                sel = j[1:0];
                #1;
                if (y !== d[j]) begin
                    $display("FAIL mux4to1: d=%b sel=%b y=%b expected=%b", d, sel, y, d[j]);
                    errors = errors + 1;
                end
            end
        end
        if (errors == 0) $display("PASS tb_mux4to1: all 64 input/selection combinations passed.");
        else             $display("FAIL tb_mux4to1: %0d errors.", errors);
        $finish;
    end
endmodule
