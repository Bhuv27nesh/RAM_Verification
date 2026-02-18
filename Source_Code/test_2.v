module test_2();

    integer i;

    initial begin
        #200;

        for (i = 0; i < 20; i = i + 1) begin

            // Write data = address value
            tb_memory.write(i[7:0], i[9:0]);

            // Read back
            tb_memory.read(i[9:0]);

            if (tb_memory.data_out == i[7:0]) begin
                $display("-------------------------------------");
                $display("---- ADDRESS TEST PASSED (addr=%0d) ----", i);
                $display("-------------------------------------");
            end
            else begin
                $display("---- ADDRESS TEST FAILED (addr=%0d) ----", i);
            end

        end

        #100 $finish;
    end

endmodule
