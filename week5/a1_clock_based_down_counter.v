// ---------------------------------------------------------
//          digital clock (sec) based Down Counter
// Assignment: week5 assignment A1
// Course: practice in digital logic design
// --------------------- list ---------------------
// 1. NCO (1M Hz) << week4 P1 / week5 P1
// 2. 59~0 Counter 
// 3. NCO_CNT (59~0 sec)
// 4. double figure separate ( tens digit / units digits ) << week5 P1
// 5. FND decoder << week4 P31 / week5 P1
// 6. LED display << week5 P1
// A1: top NCO counter display
// ---------------------------------------------------------

// ------------------------------------------------
// NCO (1M Hz)
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
// 59~0 Counter
// ------------------------------------------------
module cnt_down( out, clk, rst_n );

output	[5:0]	out	;
input		clk	;
input		rst_n	;
reg	[5:0]	out	;

always 	@(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		out <= 6'd59	;
	end else begin
		if (out < 6'd0) begin
			out <= 6'd59;
		end else begin
			out <= out - 1'b1;
		end
	end
end
endmodule

// ------------------------------------------------
// NCO_CNT (59~0 sec)
// ------------------------------------------------
module nco_cnt_down ( o_nco_cnt, i_nco_num, clk, rst_n );

output	[5:0]	o_nco_cnt	;
input	[31:0]	i_nco_num	;
input		clk		;
input		rst_n		;
wire		clk_gen		;

nco		nco_1 ( .clk_gen ( clk_gen ), .num ( i_nco_num ), .clk ( clk ), .rst_n ( rst_n ));
cnt_down	cnt_1 ( .out ( o_nco_cnt ), .clk ( clk_gen ), .rst_n ( rst_n ));

endmodule
// ---------------------------------------------------------
// double figure separate ( tens digit / units digits )
// ---------------------------------------------------------
module double_fig_sep ( o_left, o_right, i_double_fig );

output	[3:0]	o_left		;
output	[3:0]	o_right		;
input	[5:0]	i_double_fig	;

assign o_left	= i_double_fig / 10	;
assign o_right	= i_double_fig % 10	;

endmodule

// ------------------------------------------------
// FND decoder
// ------------------------------------------------
module	fnd_dec ( o_seg, i_num );

output	[6:0]	o_seg	;	// segment
input	[3:0]	i_num	;	// input number
reg	[6:0]	o_seg	;

always	@(*)	begin
	case (i_num)
		4'b0000 : o_seg = 8'b111_1110;	// 0
		4'b0001 : o_seg = 8'b011_0000;	// 1
		4'b0010 : o_seg = 8'b110_1101;	// 2
		4'b0011 : o_seg = 8'b111_1001;	// 3
		4'b0100 : o_seg = 8'b011_0011;	// 4
		4'b0101 : o_seg = 8'b101_1011;	// 5
		4'b0110 : o_seg = 8'b101_1111;	// 6
		4'b0111 : o_seg = 8'b111_0000;	// 7
		4'b1000 : o_seg = 8'b111_1111;	// 8
		4'b1001 : o_seg = 8'b111_0011;	// 9
		4'b1010 : o_seg = 8'b111_0111;	// A
		4'b1011 : o_seg = 8'b001_1111;	// B
		4'b1100 : o_seg = 8'b100_1110;	// C
		4'b1101 : o_seg = 8'b011_1101;	// D
		4'b1110 : o_seg = 8'b100_1111;	// E
		4'b1111 : o_seg = 8'b100_0111;	// F
		default : o_seg = 8'b000_0000;
	endcase
end
endmodule

// ------------------------------------------------
// LED display
// ------------------------------------------------
module	led_disp ( o_seg, o_seg_dp, o_seg_enb, i_six_digit_seg, i_six_dp, clk, rst_n );

output	[5:0]	o_seg_enb	;	// common cathod
output		o_seg_dp	;	// chosen common cathod's dot
output	[6:0]	o_seg		;	// chosen common cathod's 7 seg
input	[41:0]	i_six_digit_seg	;	// all segment
input	[5:0]	i_six_dp	;	// all dot
input		clk		;
input		rst_n		;
wire		gen_clk		;

// *********************** .o_gen_clk (x), .clk_gen modified (o) ***********************
// *********************** num*(1/100) ***********************
nco	u_nco ( .clk_gen ( clk_gen ), .num ( 32'd100000 ), .clk ( clk ), .rst_n ( rst_n ));

reg	[3:0]	cnt_common_node	;

always	@(posedge clk_gen or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		cnt_common_node <= 32'd0;
	end else begin
		if (cnt_common_node >= 4'd5) begin // 0~5 counter for common cathod
			cnt_common_node <= 4'd0;
		end else begin
			cnt_common_node <= cnt_common_node + 1'b1;
		end
	end
end

reg	[5:0]	o_seg_enb	;

always	@(cnt_common_node) begin
	case (cnt_common_node)
		4'd0 : o_seg_enb = 6'b111110;
		4'd1 : o_seg_enb = 6'b111101;
		4'd2 : o_seg_enb = 6'b111011;
		4'd3 : o_seg_enb = 6'b110111;
		4'd4 : o_seg_enb = 6'b101111;
		4'd5 : o_seg_enb = 6'b011111;
	endcase
end

reg		o_seg_dp	;

always	@(cnt_common_node) begin
	case (cnt_common_node)
		4'd0 : o_seg_dp = i_six_dp[0];
		4'd1 : o_seg_dp = i_six_dp[1];
		4'd2 : o_seg_dp = i_six_dp[2];
		4'd3 : o_seg_dp = i_six_dp[3];
		4'd4 : o_seg_dp = i_six_dp[4];
		4'd5 : o_seg_dp = i_six_dp[5];
	endcase
end

reg	[6:0]	o_seg		;

always	@(cnt_common_node) begin
	case (cnt_common_node)
		4'd0 : o_seg = i_six_digit_seg[6:0];
		4'd1 : o_seg = i_six_digit_seg[13:7];
		4'd2 : o_seg = i_six_digit_seg[20:14];
		4'd3 : o_seg = i_six_digit_seg[27:21];
		4'd4 : o_seg = i_six_digit_seg[34:28];
		4'd5 : o_seg = i_six_digit_seg[41:35];
	endcase
end

endmodule

// ------------------------------------------------
// A1: top NCO counter display
// ------------------------------------------------
module top_nco_cnt_disp_down ( o_seg, o_seg_dp, o_seg_enb, clk, rst_n );

output	[5:0]	o_seg_enb	;
output		o_seg_dp	;
output	[6:0]	o_seg		;

input		clk		;
input		rst_n		;

wire	[5:0]	o_nco_cnt	;

nco_cnt_down	u_nco_cnt_down ( .o_nco_cnt ( o_nco_cnt ), .i_nco_num ( 32'd50000000 ), .clk ( clk ), .rst_n ( rst_n ));

wire	[3:0]	o_left		;
wire	[3:0]	o_right		;

double_fig_sep	u_double_fig_sep ( .o_left ( o_left ), .o_right ( o_right ), .i_double_fig ( o_nco_cnt ));

wire	[6:0]	o_seg_left	;
wire	[6:0]	o_seg_right	;

fnd_dec		u0_fnd_dec ( .o_seg ( o_seg_left ), .i_num ( o_left ));
fnd_dec		u1_fnd_dec ( .o_seg ( o_seg_right ), .i_num ( o_right ));

wire	[41:0]	i_six_digit_seg	;

assign		i_six_digit_seg = { {4{7'b0000000}}, o_seg_left, o_seg_right };

led_disp	u_led_disp ( .o_seg ( o_seg ), .o_seg_dp ( o_seg_dp ), .o_seg_enb ( o_seg_enb ), .i_six_digit_seg ( i_six_digit_seg ), .i_six_dp ( 6'd0 ), .clk ( clk ), .rst_n ( rst_n ));

endmodule
