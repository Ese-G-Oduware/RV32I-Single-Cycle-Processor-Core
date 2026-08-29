`define DATA_WIDTH 32

`define BRANCH_BEQ      3'b000 // Branch Equal
`define BRANCH_BNE      3'b001 // Branch Not Equal
`define BRANCH_BLT      3'b100 // Branch Less Than
`define BRANCH_BGE      3'b101 // Branch Greater Than Or Equal
`define BRANCH_BLTU     3'b110 // Branch Less Than Unsigned
`define BRANCH_BGEU     3'b111 // Branch Greater Than Or Equal Unsigned
`define BRANCH_JAL_JALR 3'b010 // Jump in case of JAL or JALR instrucion

module branch_unit (
    input wire i_branch,
    input wire [2:0] i_branch_op,
    input wire [`DATA_WIDTH-1:0] i_a,
    input wire [`DATA_WIDTH-1:0] i_b,
    output reg o_take
);

    always @* begin
        o_take = 0;
        if(i_branch) begin
            case (i_branch_op)
                `BRANCH_BEQ: begin
                    if(i_a == i_b) begin 
                        o_take = 1;
                    end
                end 
                `BRANCH_BNE: begin
                    if(i_a != i_b) begin
                        o_take = 1;
                    end
                end
                `BRANCH_BLT: begin
                    if($signed(i_a) < $signed(i_b)) begin
                        o_take = 1;
                    end
                end
                `BRANCH_BGE:begin
                    if($signed(i_a) >= $signed(i_b)) begin
                        o_take = 1;
                    end
                end
                `BRANCH_BLTU:begin
                    if(i_a < $unsigned(i_b)) begin
                        o_take = 1;
                    end
                end
                `BRANCH_BGEU:begin
                    if(i_a >= $unsigned(i_b)) begin
                        o_take = 1;
                    end
                end
              	`BRANCH_JAL_JALR: begin 
                    o_take = 1;
                end
                default: o_take = 0; 
            endcase
        end
    end

endmodule