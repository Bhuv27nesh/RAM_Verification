//Given 1024x8 Synchronous RAM. Perform directed Verification. Use tasks to obtain 
//good code density. Identify bugs if any. 
//memory module 
/*
module mem1024x8(clk, rst_n, wr,data_in,address,data_out); 
    input wr,clk,rst_n; 
    input [7:0]data_in; 
    input [9:0] address; 
    output [7:0]data_out; 
        reg [7:0] mem [0:1024]; // Memory Array 1024x8 
        reg [7:0] data_out; 
        integer i; 
        wire [9:0] mem_address = {address[9:1],1'b1}; 

        always @(posedge clk or negedge rst_n) begin 
            if(!rst_n) begin 
                for(i=0;i<1024;i=i+1) 
                    mem[i]<=8'd0; 
            end 
            else if(wr) 
                mem[mem_address]<=data_in; 
            else 
                data_out<=mem[mem_address]; 
        end 
endmodule
*/

/*
    These are the error that have to be rectified from the above design  :
	1)Memory size is incorrect: reg [7:0] mem [0:1024]; creates 1025 memory 
	locations instead of 1024. It should be [0:1023].

	2)Wrong address manipulation: wire [9:0] mem_address = {address[9:1],1'b1}; forces the LSB to 1, 
	so only odd addresses are accessed and even addresses are never used.

	3)Because of the modified mem_address, the actual input address is not directly used, which breaks correct memory mapping.

	4)The declaration output [7:0] data_out; followed by reg [7:0] data_out; is redundant. It should be declared once as output reg [7:0] data_out;.

	5)data_out is not assigned during reset, which can leave it in an unknown (X) state after reset in simulation.

	6)Read and write are mutually exclusive using else if(wr) ... else ..., meaning read occurs only when wr=0. 
	There is no defined behavior for simultaneous read and write requirements.

	7)Read operation is synchronous (inside posedge block), but there is no explicit comment or 
	clarity that this is synchronous memory, which may cause misunderstanding in usage.

	8)No protection against out-of-range address access (if address > 1023 due to bug elsewhere, behavior is undefined).
*/

module mem1024x8(clk, rst_n, wr,data_in,address,data_out); 
    input clk;
    input rst_n;
    input wr;
    input [7:0] data_in;
    input [9:0] address;
    output reg [7:0] data_out;

    reg [7:0] mem [0:1023];		//Changes made here
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 1024; i = i + 1)
                mem[i] <= 8'd0;
            data_out <= 8'd0;
        end
        else begin
            if (wr)
                mem[address] <= data_in;
            else
                data_out <= mem[address];
        end
    end
endmodule



