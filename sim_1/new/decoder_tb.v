`default_nettype none
`timescale 1ns/1ns

`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED at %2d in %m: signal != value", $time); \
            $finish; \
        end

module decoder_tb;

  reg clk;
  reg [`INST_WIDTH-1:0] inst = 32'h00000000;
  wire [`OPCODE-1:0] opcode;
  wire branch;
  wire [1:0] result_mux;
  wire [2:0] branch_op;
  wire mem_write;
  wire alu_src_a;
  wire alu_src_b;
  wire reg_write;
  wire [5:0] alu_op;
  wire [$clog2(`NUM_REGISTER) - 1: 0] rs1_addr;
  wire [$clog2(`NUM_REGISTER) - 1: 0] rs2_addr;
  wire [$clog2(`NUM_REGISTER) - 1: 0] rd_addr;

  decoder dut (
    .i_inst(inst),
    .o_opcode(opcode),
    .o_branch(branch),
    .o_result_mux(result_mux),
    .o_branch_op(branch_op),
    .o_mem_write(mem_write),
    .o_alu_src_a(alu_src_a),
    .o_alu_src_b(alu_src_b),
    .o_reg_write(reg_write),
    .o_alu_op(alu_op),
    .o_rs1_addr(rs1_addr),
    .o_rs2_addr(rs2_addr),
    .o_rd_addr(rd_addr)
  );

  initial begin
    clk = 1'b0;
  end

  always #5 clk = ~clk;
  
  initial begin
       inst = 32'h0007b2b7; //lui x5, 123
    #10;
        `assert(dut.o_opcode, `OP_LUI);
        `assert(dut.o_branch, 1'b0);
        `assert(dut.o_result_mux, 2'b00);        
        `assert(dut.o_mem_write, 1'b0);
        `assert(dut.o_alu_src_a, 1'b0);
        `assert(dut.o_alu_src_b, 1'b1); 
        `assert(dut.o_reg_write, 1'b1); 
        `assert(dut.o_alu_op, `OP_ALU_ADD);
        //`assert(dut.o_rs1_addr, 5'b00100);
        //`assert(dut.o_rs2_addr, 5'b00000);
        `assert(dut.o_rd_addr, 5'b00101);


        inst = 32'h0007b297; //auipc x5, 123
    #10;
        `assert(dut.o_opcode, `OP_AUIPC);
        `assert(dut.o_branch, 1'b0);
        `assert(dut.o_result_mux, 2'b00);             
        `assert(dut.o_mem_write, 1'b0);        
        `assert(dut.o_alu_src_a, 1'b1);        
        `assert(dut.o_alu_src_b, 1'b1); 
        `assert(dut.o_reg_write, 1'b1); 
        `assert(dut.o_alu_op, `OP_ALU_ADD);
        //`assert(dut.o_rs1_addr, 5'b00101);
        //`assert(dut.o_rs2_addr, 5'b00000);
        `assert(dut.o_rd_addr, 5'b00101);    


        inst = 32'h4d000bef; //jal x23, 1232
    #10;
        `assert(dut.o_opcode, `OP_JAL);
        `assert(dut.o_branch, 1'b1);
        `assert(dut.o_result_mux, 2'b01);             
        `assert(dut.o_mem_write, 1'b0);        
        `assert(dut.o_alu_src_a, 1'b1);        
        `assert(dut.o_alu_src_b, 1'b1); 
        `assert(dut.o_branch_op, `BRANCH_JAL_JALR); 
        `assert(dut.o_reg_write, 1'b1); 
        `assert(dut.o_alu_op, `OP_ALU_ADD);
        //`assert(dut.o_rs1_addr, 5'b00101);
        //`assert(dut.o_rs2_addr, 5'b00000);
        `assert(dut.o_rd_addr, 5'b10111);


        inst = 32'h4d000be7; //jalr x23, 1232(x0)
    #10;
        `assert(dut.o_opcode, `OP_JALR);
        `assert(dut.o_branch, 1'b1);
        `assert(dut.o_result_mux, 2'b01);             
        `assert(dut.o_mem_write, 1'b0);        
        `assert(dut.o_alu_src_a, 1'b0);        
        `assert(dut.o_alu_src_b, 1'b1); 
        `assert(dut.o_branch_op, `BRANCH_JAL_JALR); 
        `assert(dut.o_reg_write, 1'b1); 
        `assert(dut.o_alu_op, `OP_ALU_ADD);
        //`assert(dut.o_rs1_addr, 5'b00101);
        //`assert(dut.o_rs2_addr, 5'b00000);
        `assert(dut.o_rd_addr, 5'b10111);

        
        inst = 32'h03924563; //blt x4, x25, 42
    #10;
        `assert(dut.o_opcode, `OP_BRANCH);
        `assert(dut.o_branch, 1'b1);
        `assert(dut.o_result_mux, 2'b00);             
        `assert(dut.o_mem_write, 1'b0);        
        `assert(dut.o_alu_src_a, 1'b1);        
        `assert(dut.o_alu_src_b, 1'b1); 
        `assert(dut.o_branch_op, `BRANCH_BLT); 
        `assert(dut.o_reg_write, 1'b0); 
        `assert(dut.o_alu_op, `OP_ALU_ADD);
        `assert(dut.o_rs1_addr, 5'b00100);
        `assert(dut.o_rs2_addr, 5'b11001);
        //`assert(dut.o_rd_addr, 5'b10111);


       inst = 32'h01713703; //ld x14, 23(x2)
    #10;
        `assert(dut.o_opcode, `OP_LOAD);
        `assert(dut.o_branch, 1'b0);
        `assert(dut.o_result_mux, 2'b10);             
        `assert(dut.o_mem_write, 1'b0);        
        `assert(dut.o_alu_src_a, 1'b0);        
        `assert(dut.o_alu_src_b, 1'b1); 
        //`assert(dut.o_branch_op, `BRANCH_BLT); 
        `assert(dut.o_reg_write, 1'b1); 
        `assert(dut.o_alu_op, `OP_ALU_ADD);
        `assert(dut.o_rs1_addr, 5'b00010);
        //`assert(dut.o_rs2_addr, 5'b01110);
        `assert(dut.o_rd_addr, 5'b01110);


       inst = 32'h00e12ba3; //sw x14, 23(x2)
    #10;
        `assert(dut.o_opcode, `OP_STORE);
        `assert(dut.o_branch, 1'b0);
        `assert(dut.o_result_mux, 2'b00);             
        `assert(dut.o_mem_write, 1'b1);        
        `assert(dut.o_alu_src_a, 1'b0);        
        `assert(dut.o_alu_src_b, 1'b1); 
        //`assert(dut.o_branch_op, `BRANCH_BLT); 
        `assert(dut.o_reg_write, 1'b0); 
        `assert(dut.o_alu_op, `OP_ALU_ADD);
        `assert(dut.o_rs1_addr, 5'b00010);
        `assert(dut.o_rs2_addr, 5'b01110);
        //`assert(dut.o_rd_addr, 5'b01110);


       inst = 32'h00f0c1b3; //xor x3, x1, x15
    #10;
        `assert(dut.o_opcode, `OP_ALU);
        `assert(dut.o_branch, 1'b0);
        `assert(dut.o_result_mux, 2'b00);             
        `assert(dut.o_mem_write, 1'b0);        
        `assert(dut.o_alu_src_a, 1'b0);        
        `assert(dut.o_alu_src_b, 1'b0); 
        //`assert(dut.o_branch_op, `BRANCH_BLT); 
        `assert(dut.o_reg_write, 1'b1); 
        `assert(dut.o_alu_op, `OP_ALU_XOR);
        `assert(dut.o_rs1_addr, 5'b00001);
        `assert(dut.o_rs2_addr, 5'b01111);
        `assert(dut.o_rd_addr, 5'b00011);


        inst = 32'h02020113; //addi x2, x4, 32
    #10;
        `assert(dut.o_opcode, `OP_ALUI);
        `assert(dut.o_branch, 1'b0);
        `assert(dut.o_result_mux, 2'b00);             
        `assert(dut.o_mem_write, 1'b0);        
        `assert(dut.o_alu_src_a, 1'b0);        
        `assert(dut.o_alu_src_b, 1'b1); 
        `assert(dut.o_reg_write, 1'b1); 
        `assert(dut.o_alu_op, `OP_ALU_ADD);
        `assert(dut.o_rs1_addr, 5'b00100);
        //`assert(dut.o_rs2_addr, 5'b00000);
        `assert(dut.o_rd_addr, 5'b00010);

    $finish;
  end

  always @(posedge clk) begin 
    $display("time %2t, inst = %8h, opcode = %7b, branch = %b, result_mux = %2b, branch_op = %3b, mem_write = %b, alu_src_a = %b, alu_src_b = %b, reg_write = %b, alu_op = %5b, rs1_addr = %5b, rs2_addr = %5b, rd_addr = %5b", $time, inst, opcode, branch, result_mux, branch_op, mem_write, alu_src_a, alu_src_b, reg_write, alu_op, rs1_addr, rs2_addr, rd_addr);    
  end 
  
  initial begin
    $dumpfile("decoder.vcd");
    $dumpvars;  
  end

endmodule