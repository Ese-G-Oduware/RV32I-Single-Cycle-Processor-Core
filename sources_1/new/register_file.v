`define DATA_WIDTH 32
`define NUM_REGISTER 32

module register_file (
    input wire i_clk,
    input wire i_rst,
    input wire i_we,
    input wire [$clog2(`NUM_REGISTER)-1:0] i_rd_addr,
    input wire [`DATA_WIDTH-1:0] i_rd,
    input wire [$clog2(`NUM_REGISTER)-1:0] i_rs1_addr,     
    input wire [$clog2(`NUM_REGISTER)-1:0] i_rs2_addr,
    output wire [`DATA_WIDTH-1:0] o_rs1,     
    output wire [`DATA_WIDTH-1:0] o_rs2
);
    //32 Register 
    reg [`NUM_REGISTER-1:0] registers [`DATA_WIDTH-1:0];
    integer i;
    
    always @(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            for (i = 0; i < `NUM_REGISTER; i = i + 1) begin
                registers[i] <= 0;
            end
        end else if (i_we && (i_rd_addr != 0)) begin //write to a register
            registers[i_rd_addr] <= i_rd; //Prevent writing to x0
        end
    end
    //Reading data
    assign o_rs1 = (i_rs1_addr == 0) ? 32'b0 : registers[i_rs1_addr];
    assign o_rs2 = (i_rs2_addr == 0) ? 32'b0 : registers[i_rs2_addr];

endmodule