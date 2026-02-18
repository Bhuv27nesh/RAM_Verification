module test_1();

    initial begin
        #40;

        // Write A5 at address 10
        tb_memory.write(8'hA5, 10'd10);

        // Read back
        tb_memory.read(10'd10);

        if (tb_memory.data_out == 8'hA5) begin
            $display("-------------------------------------");
            $display("-------- DATA TEST 1 PASSED ---------");
            $display("-------------------------------------");
        end
        else
            $display("-------- DATA TEST 1 FAILED ---------");

        // Overwrite with 5A
        tb_memory.write(8'h5A, 10'd10);
        tb_memory.read(10'd10);

        if (tb_memory.data_out == 8'h5A) begin
            $display("-------------------------------------");
            $display("-------- DATA TEST 2 PASSED ---------");
            $display("-------------------------------------");
        end
        else
            $display("-------- DATA TEST 2 FAILED ---------");

    end

endmodule
