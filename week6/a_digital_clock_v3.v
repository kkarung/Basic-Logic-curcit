// ---------------------------------------------------------
//             digital clock v3
// Assignment: week6 practice P
// Course: practice in digital logic design
// clock (min:sec), changing mode ok, debounce
// --------------------- list ---------------------
// 1. NCO (1M Hz) << week5 P1
// 2. double figure separate ( tens digit / units digits ) << week5 P1
// 3. FND decoder << week5 P1
// 4. LED display << week5 P1
// PA: HMS counter (Hour, Minute, Second each counter)
// PB: Hour, Minute, Second total counter
// PC: Controller for sec_clk, min_clk & mode/position
// PD: Top module
// PE: Debounce
// ---------------------------------------------------------

// 01. NCO (1M Hz) << week5 P1
// 02. double figure separate ( tens digit / units digits ) << week5 P1
// 03. FND decoder << week5 P1
// 04. LED display << week5 P1
// 05. HMS counter (Hour, Minute, Second each counter)
// 06. HMS down counter (Hour, Minute, Second each counter)
// 07. Hour, Minute, Second total counter
// 08. Controller for sec_clk, min_clk & mode/position
// 09. Top module
// 10. Debounce
// 11. buzz
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

wire		clk_gen		;

// *********************** .o_gen_clk (x), .clk_gen modified (o) ***********************
nco	u_nco ( .clk_gen ( clk_gen ), .num ( 32'd100000 ), .clk ( clk ), .rst_n ( rst_n ));	// num *= 1/100

reg	[3:0]	cnt_common_node	;

always	@(posedge clk_gen or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		cnt_common_node <= 4'd0;
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

// ---------------------------------------------------
// HMS counter (Hour, Minute, Second each counter)
// ---------------------------------------------------
module hms_cnt ( o_hms_cnt, o_max_hit, i_max_cnt, clk, rst_n );

output	[5:0]	o_hms_cnt	;	// 0 ~ 59
output		o_max_hit	;	// carry
input	[5:0]	i_max_cnt	;	// 59(m,s) or 23(h)
input		clk		;
input		rst_n		;

reg	[5:0]	o_hms_cnt	;
reg		o_max_hit	;

always @(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		o_hms_cnt <= 6'd0;
		o_max_hit <= 1'b0;
	end else begin
		if (o_hms_cnt >= i_max_cnt) begin // 59(m,s) or 23(h)
			o_hms_cnt <= 6'd0;
			o_max_hit <= 1'b1;
		end else begin // 0~59
			o_hms_cnt <= o_hms_cnt + 1'b1;
			o_max_hit <= 1'b0;
		end
	end
end
endmodule

// ------------------------------------------------
// Hour, Minute, Second total counter
// ------------------------------------------------
module minsec ( o_sec, o_min, o_max_hit_sec, o_max_hit_min, 
		i_sec_clk, i_min_clk, clk, rst_n );

output	[5:0]	o_sec	;
output	[5:0]	o_min	;
output		o_max_hit_sec	;	// CLOCK mode - sec carry clk
output		o_max_hit_min	;	// CLOCK mode - min carry clk

input		i_sec_clk	;
input		i_min_clk	;
input		clk		;
input		rst_n		;

// MODE: CLOCK counter
hms_cnt		u0_hms_cnt ( .o_hms_cnt ( o_sec ), .o_max_hit ( o_max_hit_sec ), .i_max_cnt ( 6'd59 ), .clk ( i_sec_clk ), .rst_n ( rst_n ) ); // sec counter
hms_cnt		u1_hms_cnt ( .o_hms_cnt ( o_min ), .o_max_hit ( o_max_hit_min ), .i_max_cnt ( 6'd59 ), .clk ( i_min_clk ), .rst_n ( rst_n ) ); // min counter

endmodule

// ---------------------------------------------------
// Controller for sec_clk, min_clk & mode/position
// ---------------------------------------------------
module controller ( o_min_clk, o_sec_clk, 
			i_sw0, i_sw1, i_sw2, i_max_hit_sec, clk, rst_n );

output		o_min_clk	; // No [5:0], since it is just clock purse
output		o_sec_clk	; // No [5:0], since it is just clock purse

input		i_max_hit_sec	;
input		i_sw0		; // switch 0
input		i_sw1		; // switch 1
input		i_sw2		; // switch 2

input		clk		;
input		rst_n		;

parameter	MODE_CLOCK	= 2'b00	;
parameter	MODE_SETUP	= 2'b01	;

parameter	POS_SEC = 1'b0;
parameter	POS_MIN	= 1'b1;

// DEBOUNCE
wire	clk_slow		;
nco	u_nco_db ( .clk_gen ( clk_slow ), .num ( 32'd500000 ), .clk ( clk ), .rst_n ( rst_n ));

wire	sw0	;
wire	sw1	;
wire	sw2	;

debounce	u0_debounce ( .o_sw ( sw0 ), .i_sw ( i_sw0 ), .clk ( clk_slow ) );
debounce	u1_debounce ( .o_sw ( sw1 ), .i_sw ( i_sw1 ), .clk ( clk_slow ) );
debounce	u2_debounce ( .o_sw ( sw2 ), .i_sw ( i_sw2 ), .clk ( clk_slow ) );

reg		o_mode		;

// SWITCH 0: MODE
always	@(posedge sw0 or negedge rst_n) begin
	if (rst_n == 1'b0) begin // reset
		o_mode <= MODE_CLOCK;
	end else begin // when pressing button, changing mode
		o_mode <= o_mode + 1'b1;
	end
end

reg		o_position	;

// SWITCH 1: POSITION
always	@(posedge sw1 or negedge rst_n) begin
	if (rst_n == 1'b0) begin // reset
		o_position <= POS_SEC;
	end else begin // when pressing button
		o_position <= o_position + 1'b1; // changing mode
	end
end

// CLK NCO
wire		clk_1hz		;	// 1Hz clock
nco		u_nco ( .clk_gen ( clk_1hz ), .num ( 32'd50000000 ), .clk ( clk ), .rst_n ( rst_n ));

// CLK for each MODE
reg		o_sec_clk	;
reg		o_min_clk	;

always @(*) begin
	case (o_mode)
		MODE_CLOCK : begin // CLOCK mode
			o_sec_clk = clk_1hz;
			o_min_clk = i_max_hit_sec;
		end
		MODE_SETUP : begin // SETTING mode
			case (o_position)
				POS_SEC : begin // o_sec_clk returns "clk_1Hz" or "~i_sw2" clock
					o_sec_clk = ~sw2;
					o_min_clk = 1'b0; // posedge o_sec_clk >> sec++;
				end
				POS_MIN : begin // o_min_clk returns "clk_1Hz" or "~i_sw2" clock
					o_sec_clk = 1'b0;
 				  	o_min_clk = ~sw2; // posedge o_min_clk >> min++;
				end
			endcase
		end
	endcase
end

endmodule

// ---------------------------------------------------
// Top module 
// ---------------------------------------------------
module top_hms_clock ( o_seg, o_seg_dp, o_seg_enb, i_sw0, i_sw1, i_sw2, clk, rst_n );

output	[6:0]	o_seg		;
output		o_seg_dp	;
output	[5:0]	o_seg_enb	;

input		i_sw0		;
input		i_sw1		;
input		i_sw2		;
input		clk		;
input		rst_n		;

wire		mode		;
wire		position	;
wire		min_clk		;
wire		sec_clk		;
wire		max_hit_sec	;	// controller's input
wire		max_hit_min	;	// controller's input

/*module controller ( o_min_clk, o_sec_clk, 
			i_sw0, i_sw1, i_sw2, i_max_hit_sec, clk, rst_n );*/

controller 	u_ctrl ( .o_min_clk ( min_clk ), .o_sec_clk ( sec_clk ),
		.i_sw0 ( i_sw0 ) , .i_sw1 ( i_sw1 ), .i_sw2 ( i_sw2 ), 
		.i_max_hit_sec ( max_hit_sec ) , .clk ( clk ), .rst_n ( rst_n ) );

wire	[5:0]	sec		;
wire	[5:0]	min		;

/*module controller ( o_min_clk, o_sec_clk, 
			i_sw0, i_sw1, i_sw2, i_max_hit_sec, clk, rst_n );*/

minsec 		u_minsec ( .o_sec ( sec ), .o_min ( min ), .o_max_hit_sec ( max_hit_sec ), .o_max_hit_min ( max_hit_min ),
		.i_sec_clk ( sec_clk ), .i_min_clk ( min_clk ), .clk ( clk ), .rst_n ( rst_n ));

wire	[3:0]	sec_left	;
wire	[3:0]	sec_right	;
wire	[3:0]	min_left	;
wire	[3:0]	min_right	;

double_fig_sep	u0_dfs ( .o_left ( sec_left ), .o_right ( sec_right ), .i_double_fig ( sec ) ) ;
double_fig_sep	u1_dfs ( .o_left ( min_left ), .o_right ( min_right ), .i_double_fig ( min ) ) ;

wire	[6:0]	sec_left_seg	;
wire	[6:0]	sec_right_seg	;
wire	[6:0]	min_left_seg	;
wire	[6:0]	min_right_seg	;

fnd_dec		u0_fun_dec( .o_seg( sec_left_seg ), .i_num( sec_left ) );
fnd_dec		u1_fun_dec( .o_seg( sec_right_seg ), .i_num( sec_right ) );
fnd_dec		u2_fun_dec( .o_seg( min_left_seg ), .i_num( min_left ) );
fnd_dec		u3_fun_dec( .o_seg( min_right_seg ), .i_num( min_right ) );

wire	[41:0]	six_digit_seg	;
assign		six_digit_seg = { {2{7'd0}}, min_left_seg, min_right_seg, sec_left_seg, sec_right_seg };

led_disp	u_led_disp ( .o_seg ( o_seg ), .o_seg_dp ( o_seg_dp ) , .o_seg_enb ( o_seg_enb ),
		.i_six_digit_seg( six_digit_seg ), .i_six_dp ( 6'd0 ), .clk ( clk ), .rst_n ( rst_n ));

endmodule

// ---------------------------------------------------
// Debounce
// ---------------------------------------------------
module debounce ( o_sw, i_sw, clk );

output	o_sw	;
input	i_sw	;
input	clk	;

reg	dly1_sw	;
always	@(posedge clk) begin
	dly1_sw <= i_sw;
end

reg dly2_sw	;
always	@(posedge clk)begin
	dly2_sw <= dly1_sw;
end

assign	o_sw = dly1_sw | ~dly2_sw;

endmodule
