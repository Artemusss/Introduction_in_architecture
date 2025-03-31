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
reg valid;

always @(*) begin
    case(opcode_i)

        2'b00: result = first_i + second_i;

        2'b01: result = (first_i >= second_i);

        2'b10: result = second_i << first_i;

        2'b11: result = ~(first_i | second_i);
        endcase
end

always @(posedge clk_i) begin

    valid <= valid_i;

    if ((opcode_i == 2'b00) && (((first_i >> (WIDTH - 1)) == (second_i >> (WIDTH - 1))) && (result >> (WIDTH - 1)) != (first_i >> (WIDTH - 1)))) begin

        valid <= 1'b0;

    end

    if (rst_i) begin

        valid <= 1'b0;

    end else if (valid_i) begin

        result_o <= result;

    end

    valid_o <= valid;
end
endmodule