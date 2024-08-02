`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.07.2024 11:58:47
// Design Name: 
// Module Name: control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_unit(
input clk, rst, N, Z, C,
input [15:0] IR,
output reg [2:0] write_add, fir_add, sec_add,
output reg add_sel, mux_sel, pc_id, pc_inc, pc_sel, ir_id, mem_wr, reg_wr,
output reg [3:0] opcode,
output reg [7:0] status
    );
reg [4:0] state;
reg [4:0] ns;
reg ps_N, ps_Z, ps_C; 				
reg ns_N, ns_Z, ns_C;
parameter RESET = 0, FETCH = 1, DECODE = 2, ADD=3, SUB = 4, MUL = 5, MOV = 6, DIV = 7, INC = 8, DEC = 9, AND = 10, OR = 11, XOR = 12, NOT = 13,  LD = 14, ST = 15, JMP = 16, BEQ = 17, BNE = 18, CALL = 19, RET = 20, ILLEGAL = 31;

always@ (posedge clk)
begin
    if(rst)
    state = RESET;
    else
    state = ns;
end

always@ (posedge clk)
begin
    if(rst)
    {ps_N, ps_Z, ps_C} = 3'b0;
    else
    {ps_N, ps_Z, ps_C} = {ns_N, ns_Z, ns_C};
end

always@ (state)
begin
    case(state)
        RESET: begin
            write_add = 3'b0; fir_add = 3'b0; sec_add = 3'b0;
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b0;
            opcode = 4'b1111;
            {ns_N, ns_Z, ns_C} = 3'b0;
            status = 8'hFF;
            ns = FETCH; 
        end   
        FETCH: begin
            write_add = 3'b0; fir_add = 3'b0; sec_add = 3'b0;
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b1; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b1; mem_wr = 1'b0; reg_wr = 1'b0;
            opcode = 4'b1111;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C};
            status = 8'h80;
            ns = DECODE; 
        end 
        DECODE: begin
            write_add = 3'b0; fir_add = 3'b0; sec_add = 3'b0;
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b0;
            opcode = 4'b1111;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C};
            status = 8'hC0;
            case( IR[15:7])
                   8'h80: ns = ADD;
                   8'h81: ns = SUB;
                   8'h82: ns = MUL;
                   8'h83: ns = MOV;
                   8'h84: ns = DIV;
                   8'h85: ns = INC;
                   8'h86: ns = DEC;
                   8'h87: ns = AND;
                   8'h88: ns = OR;
                   8'h89: ns = XOR;
                   8'h8A: ns = NOT;
                   8'h8B: ns = LD;
                   8'h8C: ns = ST;
                   8'h8D: ns = JMP;
                   8'h8E: ns = BEQ;
                   8'h8F: ns = BNE;
                   8'h90: ns = CALL;
                   8'h91: ns = RET;
                   default: ns = ILLEGAL;
            endcase
        end 
        ADD: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b0000;
            {ns_N, ns_Z, ns_C} = {N, Z, C}; 
            status =  {ps_N, ps_Z, ps_C, 5'b00000}; 
            ns = FETCH;
        end
        SUB: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b0001;
            {ns_N, ns_Z, ns_C} = {N, Z, C}; 
            status = 8'hC0;
            ns = FETCH;
        end
        MUL: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b0010;
            {ns_N, ns_Z, ns_C} = {N, Z, C}; 
            status = {ps_N, ps_Z, ps_C, 5'b00010};
            ns = FETCH;
        end
        MOV: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 5'b00000;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C};
            status = {ps_N, ps_Z, ps_C, 5'b00011}; 
            ns = FETCH;
        end
        DIV: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b0011;
            {ns_N, ns_Z, ns_C} = {N, Z, C}; 
            status = {ps_N, ps_Z, ps_C, 5'b00100}; 
            ns = FETCH;
        end
        INC: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b0100;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b00110};
            ns = FETCH;
        end
        DEC: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b0101;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b01000};
            ns = FETCH;
        end
        AND: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b0110;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b01001};
            ns = FETCH;
        end
        OR: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b0111;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C};
            status = {ps_N, ps_Z, ps_C, 5'b01010};
            ns = FETCH;
        end
        XOR: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b1000;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b01011};
            ns = FETCH;
        end
        NOT: begin
            write_add = IR[8:6]; fir_add = IR[5:3]; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b1001;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C};
            status = {ps_N, ps_Z, ps_C, 5'b01100};
            ns = FETCH;
        end
        LD: begin
            write_add = IR[8:6]; fir_add = IR[2:0]; sec_add = 4'b0;
            add_sel = 1'b1; mux_sel = 1'b1; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b1;
            opcode = 4'b1010;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b01101};
            ns = FETCH;
        end
        ST: begin
            write_add = 3'b000; fir_add = IR[5:3]; sec_add = 3'b000;
            add_sel = 1'b1; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b1; reg_wr = 1'b0;
            opcode = 4'b1011;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b01110}; 
            ns = FETCH;
        end
        JMP: begin
            write_add = 3'b000; fir_add = 3'b000; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b1; pc_inc = 1'b0; pc_sel = 1'b1; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b0;
            opcode = 4'b1111;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b01111};
            ns = FETCH; 
        end
        BEQ: begin
            write_add = 3'b000; fir_add = 3'b000; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b1; pc_inc = 1'b0; pc_sel = 1'b1; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b0;
            opcode = 4'b1111;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b10000} ;
            ns = (ps_Z) ? FETCH : DECODE; 
        end
        BNE: begin
            write_add = 3'b000; fir_add = 3'b000; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b1; pc_inc = 1'b0; pc_sel = 1'b1; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b0;
            opcode = 4'b1111;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b10001} ;
            ns = (ps_Z == 0) ? FETCH : DECODE; 
        end
        CALL: begin
            write_add = 3'b000; fir_add = 3'b000; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b1; pc_inc = 1'b0; pc_sel = 1'b1; ir_id = 1'b0; mem_wr = 1'b1; reg_wr = 1'b0;
            opcode = 4'b1111;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b10010} ;
            ns = FETCH; 
        end
        RET: begin
            write_add = 3'b000; fir_add = 3'b000; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b1; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b1; reg_wr = 1'b0;
            opcode = 4'b1111;
            {ns_N, ns_Z, ns_C} = {ps_N, ps_Z, ps_C}; 
            status = {ps_N, ps_Z, ps_C, 5'b10011} ;
            ns = FETCH; 
        end
        ILLEGAL: begin
            write_add = 3'b000; fir_add = 3'b000; sec_add = IR[2:0];
            add_sel = 1'b0; mux_sel = 1'b0; pc_id = 1'b0; pc_inc = 1'b0; pc_sel = 1'b0; ir_id = 1'b0; mem_wr = 1'b0; reg_wr = 1'b0;
            opcode = 4'b1111;
            {ns_N, ns_Z, ns_C} = 3'b000; 
            status = 8'hF0;
            ns = ILLEGAL; 
        end
    endcase
end
endmodule
