`define INST_WIDTH 32

module instruction_memory #(
    // MEM_SIZE in Words
    parameter MEM_SIZE = 1024
)  (
  	input wire [$clog2(MEM_SIZE)-1:0] i_addr,
  	output reg [`INST_WIDTH-1:0] o_inst
);

    reg [`INST_WIDTH-1:0] memory [0:MEM_SIZE-1];

initial begin
        memory[0] = 32'hf0000137; memory[1] = 32'h00010113; memory[2] = 32'h250000ef;
        memory[3] = 32'h00100073; memory[4] = 32'hff1ff06f; memory[5] = 32'hfe010113;
        memory[6] = 32'h00812e23; memory[7] = 32'h02010413; memory[8] = 32'hfea42623;
        memory[9] = 32'hfec42783; memory[10] = 32'h00179793; memory[11] = 32'h00078513;
        memory[12] = 32'h01c12403; memory[13] = 32'h02010113; memory[14] = 32'h00008067;
        memory[15] = 32'hfd010113; memory[16] = 32'h02112623; memory[17] = 32'h02812423;
        memory[18] = 32'h03010413; memory[19] = 32'h00a00793; memory[20] = 32'hfef42623;
        memory[21] = 32'h01400793; memory[22] = 32'hfef42423; memory[23] = 32'hfec42703;
        memory[24] = 32'hfe842783; memory[25] = 32'h00f707b3; memory[26] = 32'hfef42223;
        memory[27] = 32'hfec42703; memory[28] = 32'hfe842783; memory[29] = 32'h40f707b3;
        memory[30] = 32'hfef42023; memory[31] = 32'hfe842583; memory[32] = 32'hfec42503;
        memory[33] = 32'h208000ef; memory[34] = 32'h00050793; memory[35] = 32'hfcf42e23;
        memory[36] = 32'hfec42583; memory[37] = 32'hfe842503; memory[38] = 32'h218000ef;
        memory[39] = 32'h00050793; memory[40] = 32'hfcf42c23; memory[41] = 32'hfe842783;
        memory[42] = 32'hfec42583; memory[43] = 32'h00078513; memory[44] = 32'h284000ef;
        memory[45] = 32'h00050793; memory[46] = 32'hfcf42a23; memory[47] = 32'h00000013;
        memory[48] = 32'h00078513; memory[49] = 32'h02c12083; memory[50] = 32'h02812403;
        memory[51] = 32'h03010113; memory[52] = 32'h00008067; memory[53] = 32'hfe010113;
        memory[54] = 32'h00812e23; memory[55] = 32'h02010413; memory[56] = 32'hfe042623;
        memory[57] = 32'hfe042423; memory[58] = 32'h0200006f; memory[59] = 32'hfec42703;
        memory[60] = 32'hfe842783; memory[61] = 32'h00f707b3; memory[62] = 32'hfef42623;
        memory[63] = 32'hfe842783; memory[64] = 32'h00178793; memory[65] = 32'hfef42423;
        memory[66] = 32'hfe842703; memory[67] = 32'h00900793; memory[68] = 32'hfce7dee3;
        memory[69] = 32'hfec42703; memory[70] = 32'h02800793; memory[71] = 32'h00e7da63;
        memory[72] = 32'hfec42783; memory[73] = 32'h01478793; memory[74] = 32'hfef42623;
        memory[75] = 32'h0100006f; memory[76] = 32'hfec42783; memory[77] = 32'hfec78793;
        memory[78] = 32'hfef42623; memory[79] = 32'h00000013; memory[80] = 32'h00078513;
        memory[81] = 32'h01c12403; memory[82] = 32'h02010113; memory[83] = 32'h00008067;
        memory[84] = 32'hfc010113; memory[85] = 32'h02812e23; memory[86] = 32'h04010413;
        memory[87] = 32'hfca42623; memory[88] = 32'hfcc42783; memory[89] = 32'h00279793;
        memory[90] = 32'hfef42623; memory[91] = 32'hfcc42783; memory[92] = 32'h0027d793;
        memory[93] = 32'hfef42423; memory[94] = 32'h00f00793; memory[95] = 32'hfef42223;
        memory[96] = 32'hfcc42703; memory[97] = 32'hfe442783; memory[98] = 32'h00f777b3;
        memory[99] = 32'hfef42023; memory[100] = 32'hfcc42783; memory[101] = 32'hfff7c793;
        memory[102] = 32'hfcf42e23; memory[103] = 32'hfcc42783; memory[104] = 32'h00179713;
        memory[105] = 32'hfcc42783; memory[106] = 32'h0017d793; memory[107] = 32'h00f707b3;
        memory[108] = 32'hfcf42c23; memory[109] = 32'hfcc42783; memory[110] = 32'h0a57c793;
        memory[111] = 32'hfcf42a23; memory[112] = 32'h00000013; memory[113] = 32'h03c12403;
        memory[114] = 32'h04010113; memory[115] = 32'h00008067; memory[116] = 32'hfd010113;
        memory[117] = 32'h02812623; memory[118] = 32'h03010413; memory[119] = 32'hfca42e23;
        memory[120] = 32'hfdc42783; memory[121] = 32'h04f05e63; memory[122] = 32'hfe042623;
        memory[123] = 32'h00100793; memory[124] = 32'hfef42423; memory[125] = 32'h00100793;
        memory[126] = 32'hfef42223; memory[127] = 32'h0300006f; memory[128] = 32'hfec42703;
        memory[129] = 32'hfe842783; memory[130] = 32'h00f707b3; memory[131] = 32'hfef42023;
        memory[132] = 32'hfe842783; memory[133] = 32'hfef42623; memory[134] = 32'hfe042783;
        memory[135] = 32'hfef42423; memory[136] = 32'hfe442783; memory[137] = 32'h00178793;
        memory[138] = 32'hfef42223; memory[139] = 32'hfe442703; memory[140] = 32'hfdc42783;
        memory[141] = 32'hfcf746e3; memory[142] = 32'hfec42783; memory[143] = 32'h00c0006f;
        memory[144] = 32'h00000013; memory[145] = 32'h00000013; memory[146] = 32'h00078513;
        memory[147] = 32'h02c12403; memory[148] = 32'h03010113; memory[149] = 32'h00008067;
        memory[150] = 32'hfe010113; memory[151] = 32'h00112e23; memory[152] = 32'h00812c23;
        memory[153] = 32'h02010413; memory[154] = 32'h00500513; memory[155] = 32'hf65ff0ef;
        memory[156] = 32'hfea42623; memory[157] = 32'h00000793; memory[158] = 32'h00078513;
        memory[159] = 32'h01c12083; memory[160] = 32'h01812403; memory[161] = 32'h02010113;
        memory[162] = 32'h00008067; memory[163] = 32'h00050613; memory[164] = 32'h00000513;
        memory[165] = 32'h0015f693; memory[166] = 32'h00068463; memory[167] = 32'h00c50533;
        memory[168] = 32'h0015d593; memory[169] = 32'h00161613; memory[170] = 32'hfe0596e3;
        memory[171] = 32'h00008067; memory[172] = 32'h06054063; memory[173] = 32'h0605c663;
        memory[174] = 32'h00058613; memory[175] = 32'h00050593; memory[176] = 32'hfff00513;
        memory[177] = 32'h02060c63; memory[178] = 32'h00100693; memory[179] = 32'h00b67a63;
        memory[180] = 32'h00c05863; memory[181] = 32'h00161613; memory[182] = 32'h00169693;
        memory[183] = 32'hfeb66ae3; memory[184] = 32'h00000513; memory[185] = 32'h00c5e663;
        memory[186] = 32'h40c585b3; memory[187] = 32'h00d56533; memory[188] = 32'h0016d693;
        memory[189] = 32'h00165613; memory[190] = 32'hfe0696e3; memory[191] = 32'h00008067;
        memory[192] = 32'h00008293; memory[193] = 32'hfb5ff0ef; memory[194] = 32'h00058513;
        memory[195] = 32'h00028067; memory[196] = 32'h40a00533; memory[197] = 32'h00b04863;
        memory[198] = 32'h40b005b3; memory[199] = 32'hf9dff06f; memory[200] = 32'h40b005b3;
        memory[201] = 32'h00008293; memory[202] = 32'hf91ff0ef; memory[203] = 32'h40a00533;
        memory[204] = 32'h00028067; memory[205] = 32'h00008293; memory[206] = 32'h0005ca63;
        memory[207] = 32'h00054c63; memory[208] = 32'hf79ff0ef; memory[209] = 32'h00058513;
        memory[210] = 32'h00028067; memory[211] = 32'h40b005b3; memory[212] = 32'hfe0558e3;
        memory[213] = 32'h40a00533; memory[214] = 32'hf61ff0ef; memory[215] = 32'h40b00533;
        memory[216] = 32'h00028067;
    end

   	always @(*) begin
        o_inst = memory[i_addr >> 2];
   	end
    
  
endmodule
