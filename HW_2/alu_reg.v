module alu_reg #(
    parameter WIDTH = 8
)(
    input clk_i,
    input rst_i,
    input valid_i,
    input [WIDTH-1:0] first_i,
    input [WIDTH-1:0] second_i,
    input [1:0] opcode_i,

    output reg valid_o,
    output reg [WIDTH-1:0] result_o
);

reg [WIDTH-1:0] result;

always @(*) begin
    case(opcode_i)

        2'b00: result = first_i + second_i;

        2'b01: result = (first_i >= second_i);

        2'b10: result = second_i << first_i;

        2'b11: result = ~(first_i | second_i);

    endcase
end

always @(posedge clk_i) begin

    if (rst_i) begin
        valid_o <= 1'b0;

    end else begin
        valid_o <= valid_i;

        if (valid_i) begin
            result_o <= result;

        end
    end
end

endmodule
