// ---------------------------------------------------------
// NCO (Numerical Controlled Oscillator) design
// lecture: practice in digital logic design
// week4 practice P1
// nco: digital signal generator e.g. clock
// --------------------- list ---------------------
// P1: Numerical Controlled Oscillator
// ---------------------------------------------------------

// ------------------------------------------------
// P1: Numerical Controlled Oscillator
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
