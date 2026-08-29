`default_nettype none
`timescale 1ns/1ns

`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED at %2d in %m: signal != value", $time); \
            $finish; \
        end

module inst_mem_tb;

  localparam MEM_SIZE = 1024;
  reg [$clog2(MEM_SIZE)-1:0] addr = 32'h00000000;
  wire [`INST_WIDTH-1:0] inst;

  instruction_memory dut (
    .i_addr(addr),
    .o_inst(inst)
  );
  
  initial begin
    #10;
    	`assert(inst, 32'h00108113); 
    #10;
        addr = 32'h00000004;
    #10;
    	`assert(inst, 32'h00108193); 
    #10;
        addr = 32'h00000008;
    #10;
    	`assert(inst, 32'h00310233);
    #10;
        addr = 32'h0000000c;
    #10;
    	`assert(inst, 32'hfe218ae3);
    #10;
        addr = 32'h00000010;
    #10;
        `assert(inst, 32'h0000000);        
    $finish;
  end

  always @* begin 
    $display("time %2t, addr = %3h, inst = %8h", $time, addr, inst);
  end 
  
  initial begin
    $dumpfile("inst_mem.vcd");
    $dumpvars;  
  end

endmodule