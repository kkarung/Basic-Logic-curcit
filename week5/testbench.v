// ---------------------------------------------------------
//                       Test bench
// Course: practice in digital logic design
// Assignment: week5 practice 01,02
// --------------------- list ---------------------
// tb for P1
// tb_buzz for P2
// ----------------------------------------------------------

module tb;
// ------------------------------------------------
// instance
// ------------------------------------------------
wire	[6:0]	o_seg		;
wire		o_seg_dp	;
wire	[5:0]	o_seg_enb	;

reg		clk		;
reg		rst_n		;

parameter	tCK = 1000/50	;

initial		clk = 1'b0	;
always #(tCK/2)	clk = ~clk	;

top_nco_cnt_disp	u_top_nco ( .o_seg ( o_seg ), .o_seg_dp ( o_seg_dp ), .o_seg_enb ( o_seg_enb ), .clk ( clk ), .rst_n ( rst_n ) );

// ------------------------------------------------
// stimulus
// ------------------------------------------------

initial begin
	#(00*tCK)	rst_n	= 1'b0	;
	#(10*tCK)	rst_n	= 1'b1	;
	#(100000000*tCK)	$finish	;
end
endmodule

module tb_buzz;
// ------------------------------------------------
// instance
// ------------------------------------------------
wire		o_buzz		;
reg		i_buzz_en	;
reg		clk		;
reg		rst_n		;

parameter	tCK = 1000/50	;

initial		clk = 1'b0	;
always #(tCK/2)	clk = ~clk	;

buzz 	u_buzz	( .o_buzz ( o_buzz ), .i_buzz_en ( i_buzz_en ), .clk ( clk ), .rst_n ( rst_n ) );

// ------------------------------------------------
// stimulus
// ------------------------------------------------

initial begin
	#(00*tCK)	rst_n	= 1'b0	;	i_buzz_en = 1'b1;
	#(10*tCK)	rst_n	= 1'b1	;
	#(50000000*tCK)	$finish	;
end
endmodule
