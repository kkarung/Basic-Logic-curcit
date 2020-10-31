// ---------------------------------------------------------
//                 SR Latch based DFF Design
// Course: practice in digital logic design
// Assignment: week3 assignment A1
// --------------------- list ---------------------
// A2 : 4-bit Counter Design
// ---------------------------------------------------------

// ------------------------------------------------------
// A1 : SR Latch based DFF Design (Gate Level Description)
// ------------------------------------------------------
module sr_slave (	q, q_n, s, r, clk	)	;

output	q	;
output	q_n	;
input	s	;
input	r	;
input	clk	;

wire	node1	;
wire	node2	;

nand	NAND_1(	node1, s, clk	)	;	// node1
nand	NAND_2(	node2, r, clk	)	;	// node2
nand	NAND_3( q, node1, q_n	)	;	// q
nand	NAND_4(	q_n, q, node2	)	;	// q_n

endmodule

module master_dff (	s, r, d, clk		)	;

output	s	;
output	r	;
input	d	;
input	clk	;

wire	d_n	;

not 		NOT_1		(	d_n, d	)	;
sr_slave	sr_1	(	s, r, d, d_n, clk	)	;

endmodule

module dff_sr(	q, q_n, d, clk	)	;	// "negative" edge triggerd d flip flop

output	q	;
output	q_n	;
input	d	;
input	clk	;

wire	node1	;
wire	node2	;
wire	clk_n	;

not	NOT_1	(	clk_n, clk		)	;
master_dff	dff_1	(	node1, node2, d, clk	)	;
sr_slave	sr_1	(	q, q_n, node1, node2, clk_n	);

endmodule

// ------------------------------------------------
// A2 : 4-bit Counter Design
// ------------------------------------------------
module dff_pos 	(	q, q_n, d, rst_n, clk	)	; // positive edge triggered d flip flop with reset

output	q	;
output	q_n	;
input	d	;
input	rst_n	;
input	clk	;

reg	q	;
reg	q_n	;
wire	q_temp	;
wire	q_n_temp;

always	@(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		q <= 1'b0; $display("asdf\t");
	end
	else begin $display("dddd\t");	end
	q_n <= ~q;
end

assign {q_temp, q_n_temp} = {q, q_n};

dff_sr	dff_0	( .q ( q_temp ), .q_n ( q_n_temp ), .d ( d ), .clk ( clk ));

endmodule

// ------------------------------------------------
// A2 : 4-bit Counter Design
// ------------------------------------------------

module counter_4 (	q, rst_n, clk	);

output	[3:0]	q	;
input		rst_n	;
input		clk	;
wire	[3:0]	q_n	;

dff_pos	dff_1	( .q ( q[0] ), .q_n ( q_n[0] ), .d ( q_n[0] ), .rst_n ( rst_n ), .clk ( clk )); // negative edge triggered >> positive edge triggered (clk)
dff_pos	dff_2	( .q ( q[1] ), .q_n ( q_n[1] ), .d ( q_n[1] ), .rst_n ( rst_n ), .clk ( q_n[0] ));// negative edge triggered >> positive edge triggered (clk)
dff_pos	dff_3	( .q ( q[2] ), .q_n ( q_n[2] ), .d ( q_n[2] ), .rst_n ( rst_n ), .clk ( q_n[1] ));// negative edge triggered >> positive edge triggered (clk)
dff_pos	dff_4	( .q ( q[3] ), .q_n ( q_n[3] ), .d ( q_n[3] ), .rst_n ( rst_n ), .clk ( q_n[2] ));// negative edge triggered >> positive edge triggered (clk)

endmodule
