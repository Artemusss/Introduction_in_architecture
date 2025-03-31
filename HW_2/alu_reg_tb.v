`timescale 1ns/1ps
module alu_reg_tb();

localparam TEST_WIDTH = 3;

reg clk_i;
reg rst_i;
reg valid_i;
reg [TEST_WIDTH-1:0] first_i;
reg [TEST_WIDTH-1:0] second_i;
reg [1:0] opcode_i;

wire valid_o;
wire [TEST_WIDTH-1:0] result_o;

alu_reg #(
.WIDTH(TEST_WIDTH)
) malu_reg_inst (
.clk_i (clk_i),
.rst_i (rst_i),
.valid_i (valid_i),
.first_i (first_i),
.second_i(second_i),
.opcode_i(opcode_i),
.valid_o(valid_o),
.result_o(result_o)
);

always begin
    clk_i = 1'b0; #1;
    clk_i = 1'b1; #1;
    end

initial begin
    $dumpvars;

    //test reset
    @(posedge clk_i); #0.5; //enable reset
    rst_i = 1'b1;
    #3;

    @(posedge clk_i); #0.5; //disable reset
    rst_i = 1'b0;
    #3;

    //test of correct addition
    first_i = 3'b001;
    second_i = 3'b001;
    valid_i = 1'b1;
    opcode_i = 2'b00;

    @(posedge clk_i); #1; // 001 + 001 = 010 (1 + 1 = 2)
    rst_i = 1'b1; //reset
    #1;
    rst_i = 1'b0;
    #1;

    first_i = 3'b111;
    second_i = 3'b111;
    valid_i = 1'b1;
    opcode_i = 2'b00;

    @(posedge clk_i); #1; // 111 + 111 = 110 (-1 - 1 = -2)
    rst_i = 1'b1; //reset
    #1;
    rst_i = 1'b0;
    #1;

    //test of overflow addition
    first_i = 3'b011;
    second_i = 3'b011;
    valid_i = 1'b1;
    opcode_i = 2'b00;

    @(posedge clk_i); #1; // 011 + 011 = 111, valid_o should be 0
    rst_i = 1'b1; //reset
    #1;
    rst_i = 1'b0;
    #1;

    //test of second_i <= first_i
    first_i = 3'b011;
    second_i = 3'b011;
    valid_i = 1'b1;
    opcode_i = 2'b01;

    @(posedge clk_i); #1; // 011 <= 011 result_o = 1
    rst_i = 1'b1; //reset
    #1;
    rst_i = 1'b0;
    #1;

    first_i = 3'b011;
    second_i = 3'b101;
    valid_i = 1'b1;
    opcode_i = 2'b01;

    @(posedge clk_i); #1; // 101 > 011 result_o = 0
    rst_i = 1'b1; //reset
    #1;
    rst_i = 1'b0;
    #1;

    first_i = 3'b011;
    second_i = 3'b001;
    valid_i = 1'b1;
    opcode_i = 2'b01;

    @(posedge clk_i); #1; // 001 <= 011 result_o = 1
    rst_i = 1'b1; //reset
    #1;
    rst_i = 1'b0;
    #1;

    //test of logical shift
    first_i = 3'b010;
    second_i = 3'b001;
    valid_i = 1'b1;
    opcode_i = 2'b10;

    @(posedge clk_i); #1; // 001 << 2 result_o = 100
    rst_i = 1'b1; //reset
    #1;
    rst_i = 1'b0;
    #1;

    first_i = 3'b100;
    second_i = 3'b001;
    valid_i = 1'b1;
    opcode_i = 2'b10;

    @(posedge clk_i); #1; // 001 << 4 result_o = 000
    rst_i = 1'b1; //reset
    #1;
    rst_i = 1'b0;
    #1;
    
    //test of NOR
    first_i = 3'b101;
    second_i = 3'b101;
    valid_i = 1'b1;
    opcode_i = 2'b11;

    @(posedge clk_i); #1; // ~(101 & 101) result_o = 010
    rst_i = 1'b1; //reset
    #1;
    rst_i = 1'b0;
    #1;

    $finish;
end
endmodule