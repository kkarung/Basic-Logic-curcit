// ---------------------------------------------------------
// NCO + counter Design
// lecture: practice in digital logic design
// week4 assignment A1
// --------------------- list ---------------------
// NCO
// 0~59 Counter
// A1: NCO + Counter Design
// ---------------------------------------------------------

// ------------------------------------------------
// NCO
// ------------------------------------------------
module nco ( clk_gen, num, clk, rst_n );

output		clk_gen	;
input	[31:0]	num	;
input		clk	;
input		rst_n	;

reg	[31:0]	cnt	;
reg		clk_gen	;

always	@(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin // reset
		cnt	<= 32'd0;
		clk_gen	<= 1'd0	;
	end else begin
		if (cnt >= num/2-1) begin
			cnt	<= 32'd0	;
			clk_gen	<= ~clk_gen	;
		end else begin
			cnt	<= cnt + 1'b1	;
		end
	end
end
endmodule

// ------------------------------------------------
// 0~59 Counter
// ------------------------------------------------
module cnt60( out, clk, rst_n );

output	[5:0]	out	;
input		clk	;
input		rst_n	;
reg	[5:0]	out	;

always 	@(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		out <= 6'b0	;
	end else begin
		if (out >= 6'd59) begin
			out <= 6'd0;
		end else begin
			out <= out + 1'b1;
		end
	end
end
endmodule

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
