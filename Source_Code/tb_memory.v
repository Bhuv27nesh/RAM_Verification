module tb_memory();

    reg wr, clk, rst_n;
    reg [7:0] data_in;
    reg [9:0] address;
    wire [7:0] data_out;

    parameter T = 10;

    mem1024x8 dut_memory_ins (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .wr(wr),
        .data_out(data_out),
        .address(address)
    );

    // Clock generation
    always #(T/2) clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        wr = 0;
        data_in = 0;
        address = 0;

        #20 rst_n = 1;
    end

    initial begin
        $dumpfile("mem1024x8_dump.vcd");
        $dumpvars(0, tb_memory);
    end

    initial begin
        $monitor("%0t | rst=%b | wr=%b | addr=%d | din=%h | dout=%h",$time, rst_n, wr, address, data_in, data_out);
    end

    // Write Task
    task write;
        input [7:0] din;
        input [9:0] addr;
        begin
            @(posedge clk);
            wr = 1;
            address = addr;
            data_in = din;
            @(posedge clk);
            wr = 0;
        end
    endtask

    // Read Task
    task read;
        input [9:0] addr;
        begin
            @(posedge clk);
            wr = 0;
            address = addr;
            @(posedge clk);
        end
    endtask

    // Instantiate test cases
    test_1 t1();
    test_2 t2();

endmodule
