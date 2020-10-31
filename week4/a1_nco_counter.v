// ---------------------------------------------------------
// NCO (Numerical Controlled Oscillator) design
// lecture: practice in digital logic design
// week4 assignment A1
// MUST INCLUDE nco.v, counter_59.v
// --------------------- list ---------------------
// A1: NCO + Counter Design
// ---------------------------------------------------------

// ------------------------------------------------
// A1: NCO + Counter Design
// ------------------------------------------------
module top_cnt ( out, num, clk, rst_n );

output	[5:0]	out	;
input	[31:0]	num	;
input		clk	;
input		rst_n	;
wire		clk_gen	;

nco	nco_1 ( .clk_gen ( clk_gen ), .num ( num ), .clk ( clk ), .rst_n ( rst_n )); // 1HZ clock
cnt60	cnt_1 ( .out ( out ), .clk ( clk_gen ), .rst_n ( rst_n ));

endmodule
