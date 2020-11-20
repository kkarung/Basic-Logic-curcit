// ---------------------------------------------------------
//                   digital clock
// team project - digital clock
// Course: practice in digital logic design
// mode: clock (hour:min:sec), alarm, timer / debounce
// --------------------- list ---------------------
// 01. NCO (1M Hz)
// 02. buzz
// 03. IR sensor Remote control
// 04. double figure separate ( tens digit / units digits )
// 05. FND decoder
// 06. LED display
// 07. HMS counter (Hour, Minute, Second each counter)
// 08. HMS down counter (Hour, Minute, Second each counter)
// 09. Hour, Minute, Second total counter
// 10. Controller for clk & mode/position
// 11. Top module
// 12. Debounce
// ---------------------------------------------------------

// ------------------------------------------------
// NCO (1M Hz)
// ------------------------------------------------
module	nco(	clk_gen,
		num,
		clk,
		rst_n);

output		clk_gen		;

input	[31:0]	num		;
input		clk		;
input		rst_n		;

reg	[31:0]	cnt		;
reg		clk_gen		;

always @(posedge clk or negedge rst_n) begin
		if(rst_n == 1'b0) begin
			cnt	<= 32'd0	;
			clk_gen <= 1'd0		;
		end else begin	
			if(cnt >= num/2-1) begin
				cnt	<= 32'd0	;
				clk_gen <= ~clk_gen	;
			end else begin
				cnt <= cnt + 1'b1	;
			end
		end
	end
endmodule

// ---------------------------------------------------
// buzz
// ---------------------------------------------------
module   buzz(   o_buzz,
     		 i_buzz_en,
      		clk,
      		rst_n);

output      o_buzz      ;

input      i_buzz_en   ;
input      clk      ;
input      rst_n      ;

parameter   C = 191113   ;
parameter   D = 170262   ;
parameter   E = 151686   ;
parameter   F = 143173   ;
parameter   G = 63776   ;
parameter   A = 56818   ;
parameter   B = 50619   ;

wire      clk_bit      ;

nco      	u_nco_bit(   
		.clk_gen   	( clk_bit  	),
           	.num      	( 32'd10000000  ),
           	.clk      	( clk		),
            	.rst_n      	( rst_n      	));

reg   [6:0]   cnt   ;

always   @(posedge clk_bit or negedge rst_n ) begin
   	if(rst_n == 1'b0) begin
     		 cnt <= 7'd0   ;
   	end else begin
     		if(i_buzz_en == 1'b0) begin
       			  cnt <= 7'd0   ;
      		end else begin
         	if(cnt >= 7'd88) begin
            	cnt <= 7'd0   ;
         	end else begin
           	cnt <= cnt + 7'd1   ;
         	end
      	end
   	end
end

reg   [31:0]   nco_num      ;

always @(*) begin
   case(cnt)
      7'd00: nco_num = E   ;
      7'd01: nco_num = E   ;
      7'd02: nco_num = E   ;
      7'd03: nco_num = 32'd0   ;   
      7'd04: nco_num = D   ;
      7'd05: nco_num = 32'd0   ;
      7'd06: nco_num = C   ;
      7'd07: nco_num = C   ;
      7'd08: nco_num = 32'd0   ;
      7'd09: nco_num = D   ;
      7'd10: nco_num = D   ;
      7'd11: nco_num = 32'd0   ;
      7'd12: nco_num = E   ;
      7'd13: nco_num = E   ;
      7'd14: nco_num = 32'd0   ;
      7'd15: nco_num = E   ;
      7'd16: nco_num = E   ;
      7'd17: nco_num = 32'd0   ;
      7'd18: nco_num = E   ;
      7'd19: nco_num = E   ;
      7'd20: nco_num = E   ;
      7'd21: nco_num = E   ;
      7'd22: nco_num = 32'd0   ;
      7'd23: nco_num = D   ;
      7'd24: nco_num = D   ;
      7'd25: nco_num = 32'd0   ;
      7'd26: nco_num = D   ;
      7'd27: nco_num = D   ;
      7'd28: nco_num = 32'd0   ;
      7'd29: nco_num = D   ;
      7'd30: nco_num = D   ;
      7'd31: nco_num = D   ;
      7'd32: nco_num = D   ;
      7'd33: nco_num = 32'd0   ;
      7'd34: nco_num = E   ;
      7'd35: nco_num = E   ;
      7'd36: nco_num = 32'd0   ;
      7'd37: nco_num = E   ;
      7'd38: nco_num = E   ;
      7'd39: nco_num = 32'd0   ;
      7'd40: nco_num = E   ;
      7'd41: nco_num = E   ;
      7'd42: nco_num = E   ;
      7'd43: nco_num = E   ;
      7'd44: nco_num = 32'd0   ;   
      7'd45: nco_num = E   ;
      7'd46: nco_num = E   ;
      7'd47: nco_num = E   ;
      7'd48: nco_num = 32'd0   ;   
      7'd49: nco_num = D   ;
      7'd50: nco_num = 32'd0   ;
      7'd51: nco_num = C   ;
      7'd52: nco_num = C   ;
      7'd53: nco_num = 32'd0   ;
      7'd54: nco_num = D   ;
      7'd55: nco_num = D   ;
      7'd56: nco_num = 32'd0   ;
      7'd57: nco_num = E   ;
      7'd58: nco_num = E   ;
      7'd59: nco_num = 32'd0   ;
      7'd60: nco_num = E   ;
      7'd61: nco_num = E   ;
      7'd62: nco_num = 32'd0   ;
      7'd63: nco_num = E   ;
      7'd64: nco_num = E   ;
      7'd65: nco_num = E   ;
      7'd66: nco_num = E   ;
      7'd67: nco_num = 32'd0   ;
      7'd68: nco_num = D   ;
      7'd69: nco_num = D   ;
      7'd70: nco_num = 32'd0   ;
      7'd70: nco_num = D   ;
      7'd72: nco_num = D   ;
      7'd73: nco_num = 32'd0   ;
      7'd74: nco_num = E   ;
      7'd75: nco_num = E   ;
      7'd76: nco_num = E   ;
      7'd77: nco_num = 32'd0   ;   
      7'd78: nco_num = D   ;
      7'd79: nco_num = 32'd0   ;
      7'd80: nco_num = C   ;
      7'd81: nco_num = C   ;
      7'd82: nco_num = C   ;
      7'd83: nco_num = C   ;
      7'd84: nco_num = C   ;
      7'd85: nco_num = C   ;
      7'd86: nco_num = C   ;
      7'd87: nco_num = C   ;
      7'd88: nco_num = 32'd0   ;
   endcase
end

wire      buzz   ;

nco		u_nco_buzz(   
		.clk_gen	( buzz     ),
         	.num		( nco_num  ),
         	.clk      	( clk      ),
         	.rst_n     	( rst_n    ));

assign   o_buzz = buzz & i_buzz_en   ;

endmodule

// ------------------------------------------------
// IR sensor Remote control
// ------------------------------------------------
module	ir_rx(
		o_data,
		i_ir_rxb,
		clk,
		rst_n);

output	[31:0]	o_data		;

input		i_ir_rxb	;
input		clk		;
input		rst_n		;

parameter	IDLE		= 2'b00	;
// 9ms high 4.5ms low
parameter	LEADCODE	= 2'b01	;
// Custom & Data code
parameter	DATACODE 	= 2'b10	;
// 32-bit data
parameter	COMPLETE	= 2'b11	;

// 		1M Clock = 1us Reference Time
wire		clk_1M		;
nco		u_nco(	
		.clk_gen	( clk_1M	),
		.num		( 32'd50	),
		.clk		( clk		),
		.rst_n		( rst_n		));

//		Sequential Rx Bits		
wire		ir_rx			;
assign		ir_rx = ~i_ir_rxb	;

reg	[1:0]	seq_rx			;
always @(posedge clk_1M or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		seq_rx <= 2'b00;
	end else begin
		seq_rx <= {seq_rx[0], ir_rx};
	end
end

//	 	Count Signal Polarity (High & Low)
reg	[15:0]	cnt_h		;
reg	[15:0]	cnt_l		;

always @(posedge clk_1M or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		cnt_h <= 16'd0;
		cnt_l <= 16'd0;
	end else begin
		case(seq_rx)
			2'b00	: cnt_l <= cnt_l + 1;
			2'b01	: begin
				cnt_l <= 16'd0;
				cnt_h <= 16'd0;
			end
			2'b11	: cnt_h <= cnt_h + 1;
		endcase
	end
end

//		State Machine
reg	[1:0]	state		;
reg	[5:0]	cnt32		;
always @(posedge clk_1M or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		state <= IDLE;
		cnt32 <= 6'd0;
	end else begin
		case (state)
			IDLE : begin
				state <= LEADCODE;
				cnt32 <= 6'd0;
			end
			LEADCODE : begin
				if (cnt_h >= 8500 && cnt_l >= 4000) begin
					state <= DATACODE;
				end else begin
					state <= LEADCODE;
				end
			end
			DATACODE : begin
				if (seq_rx == 2'b01) begin
					cnt32 <= cnt32 + 1;
				end else begin
					cnt32 <= cnt32;
				end

				if (cnt32 >= 6'd32 && cnt_l >= 1000) begin
					state <= COMPLETE;
				end else begin
					state <= DATACODE;
				end
			end
			COMPLETE : state <= IDLE;
		endcase
	end
end

//		32bit Custom & Data Code
reg	[31:0]	data		;
reg	[31:0]	o_data		;
always @(posedge clk_1M or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		data <= 32'd0;
	end else begin
		case (state)
			IDLE	: o_data <= 32'd0	;
			DATACODE: begin
				if (cnt_l >= 1000) begin
					data[32-cnt32] <= 1'b1;
				end else begin
					data[32-cnt32] <= 1'b0;
				end
			end
			COMPLETE: o_data <= data;
		endcase
	end
end
endmodule

// ---------------------------------------------------------
// double figure separate ( tens digit / units digits )
// ---------------------------------------------------------
module	double_fig_sep(	o_left,
			o_right,
			i_double_fig);
output	[3:0]	o_left;
output	[3:0]	o_right;

input	[5:0]	i_double_fig;

assign	o_left	= i_double_fig/10;
assign	o_right	= i_double_fig%10;

endmodule

// ------------------------------------------------
// FND decoder
// ------------------------------------------------
module	fnd_dec(	o_seg,
			i_num);

output	[6:0]	o_seg	;

input	[3:0]	i_num	;

reg	[6:0]	o_seg	;

always@(*)begin
	case( i_num )
		4'b0000 : o_seg = 7'b111_1110	;	//0
		4'b0001 : o_seg = 7'b011_0000	;	//1
		4'b0010 : o_seg = 7'b110_1101	;	//2
		4'b0011 : o_seg = 7'b111_1001	;	//3
		4'b0100 : o_seg = 7'b011_0011	;	//4	
		4'b0101 : o_seg = 7'b101_1011	;	//5
		4'b0110 : o_seg = 7'b101_1111	;	//6
		4'b0111 : o_seg = 7'b111_0000	;	//7
		4'b1000 : o_seg = 7'b111_1111	;	//8
		4'b1001 : o_seg = 7'b111_0011	;	//9
		4'b1010 : o_seg = 7'b111_0111	;	//A
		4'b1011 : o_seg = 7'b111_1111	;	//B
		4'b1100 : o_seg = 7'b100_1110	;	//C
		4'b1101 : o_seg = 7'b111_1110	;	//D
		4'b1110 : o_seg = 7'b100_1111	;	//E
		4'b1111 : o_seg = 7'b100_0111	;	//F
		default : o_seg = 7'b000_0000	;
	endcase
	
end

endmodule

// ------------------------------------------------
// LED display
// ------------------------------------------------
module	led_disp(	o_seg,
			o_seg_dp,
			o_seg_enb,
			i_six_digit_seg,
			i_six_dp,
			i_position,
			i_mode,
			i_timer_en,
			clk,
			rst_n);

parameter	MODE_CLOCK = 2'b00	;
parameter	MODE_SETUP = 2'b01	;
parameter	MODE_ALARM = 2'b10	;
parameter	MODE_TIMER = 2'b11	;
parameter	POS_SEC	   = 2'b00	;
parameter	POS_MIN	   = 2'b01	;
parameter	POS_HOUR   = 2'b10	;

output	[5:0]	o_seg_enb	;
output		o_seg_dp	;
output	[6:0]	o_seg		;

input	[41:0]	i_six_digit_seg	;
input	[5:0]	i_six_dp	;
input	[1:0]	i_mode		;
input	[1:0]	i_position	;	
input		i_timer_en	;
input		clk		;
input		rst_n		;

wire		gen_clk		;
wire		gen_clk_blink	;		

nco		u0_nco(	.clk_gen	( gen_clk	),
			.num		( 32'd5000	),
			.clk		( clk		),
			.rst_n		( rst_n		));

nco		u1_nco(	.clk_gen	( gen_clk_blink	),
			.num		( 32'd5000000	),
			.clk		( clk		),
			.rst_n		( rst_n		));

reg	[3:0]	cnt_common_node	;

always@(posedge gen_clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		cnt_common_node <= 32'd0;
	end else begin
		if(cnt_common_node >= 4'd5) begin
			cnt_common_node <= 4'd0;
		end else begin
			cnt_common_node <= cnt_common_node + 1'b1;
		end
	end
end

reg		cnt_blink_node	;

always@(posedge gen_clk_blink or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		cnt_blink_node <= 32'd0;
	end else begin
		if(cnt_blink_node >= 1'd1) begin
			cnt_blink_node <= 1'd0;
		end else begin
			cnt_blink_node <= cnt_blink_node + 1'b1;
		end
	end
end

reg	[5:0]	o_seg_enb	;
always@(cnt_common_node or cnt_blink_node) begin
	if(i_mode == MODE_CLOCK ||(i_mode == MODE_TIMER && i_timer_en == 1'b1)) begin
		case(cnt_common_node)
		4'd0:o_seg_enb=6'b111110;
		4'd1:o_seg_enb=6'b111101;
		4'd2:o_seg_enb=6'b111011;
		4'd3:o_seg_enb=6'b110111;
		4'd4:o_seg_enb=6'b101111;
		4'd5:o_seg_enb=6'b011111;
		endcase
	end else begin
		case(i_position)
		POS_SEC : begin
			case(cnt_blink_node)
				1'd0: begin
					case(cnt_common_node)
					4'd0:o_seg_enb=6'b111110;
					4'd1:o_seg_enb=6'b111101;
					4'd2:o_seg_enb=6'b111011;
					4'd3:o_seg_enb=6'b110111;
					4'd4:o_seg_enb=6'b101111;
					4'd5:o_seg_enb=6'b011111;
					endcase
					end
				1'd1: begin
					case(cnt_common_node)
					4'd0:o_seg_enb=6'b111111;
					4'd1:o_seg_enb=6'b111111;
					4'd2:o_seg_enb=6'b111011;
					4'd3:o_seg_enb=6'b110111;
					4'd4:o_seg_enb=6'b101111;
					4'd5:o_seg_enb=6'b011111;
					endcase
					end	
			endcase
			end		
		POS_MIN : begin
			case(cnt_blink_node)
				1'd0: begin
					case(cnt_common_node)
					4'd0:o_seg_enb=6'b111110;
					4'd1:o_seg_enb=6'b111101;
					4'd2:o_seg_enb=6'b111011;
					4'd3:o_seg_enb=6'b110111;
					4'd4:o_seg_enb=6'b101111;
					4'd5:o_seg_enb=6'b011111;
					endcase
					end 
				1'd1: begin
					case(cnt_common_node)
					4'd0:o_seg_enb=6'b111110;
					4'd1:o_seg_enb=6'b111101;
					4'd2:o_seg_enb=6'b111111;
					4'd3:o_seg_enb=6'b111111;
					4'd4:o_seg_enb=6'b101111;
					4'd5:o_seg_enb=6'b011111;
					endcase
					end 
			endcase
			end
		POS_HOUR : begin
			case(cnt_blink_node)
				1'd0: begin
					case(cnt_common_node)
					4'd0:o_seg_enb=6'b111110;
					4'd1:o_seg_enb=6'b111101;
					4'd2:o_seg_enb=6'b111011;
					4'd3:o_seg_enb=6'b110111;
					4'd4:o_seg_enb=6'b101111;
					4'd5:o_seg_enb=6'b011111;
					endcase
					end 
				1'd1: begin
					case(cnt_common_node)
					4'd0:o_seg_enb=6'b111110;
					4'd1:o_seg_enb=6'b111101;
					4'd2:o_seg_enb=6'b111011;
					4'd3:o_seg_enb=6'b110111;
					4'd4:o_seg_enb=6'b111111;
					4'd5:o_seg_enb=6'b111111;
					endcase
					end 
			endcase
			end
		endcase
end
end

reg	o_seg_dp;

always@(cnt_common_node) begin
	case(cnt_common_node)
		4'd0:o_seg_dp=i_six_dp[0];
		4'd1:o_seg_dp=i_six_dp[1];
		4'd2:o_seg_dp=i_six_dp[2];
		4'd3:o_seg_dp=i_six_dp[3];
		4'd4:o_seg_dp=i_six_dp[4];
		4'd5:o_seg_dp=i_six_dp[5];
	endcase
end

reg	[6:0]	o_seg;

always@(cnt_common_node) begin
	case(cnt_common_node)
		4'd0:o_seg=i_six_digit_seg[6:0];
		4'd1:o_seg=i_six_digit_seg[13:7];
		4'd2:o_seg=i_six_digit_seg[20:14];
		4'd3:o_seg=i_six_digit_seg[27:21];
		4'd4:o_seg=i_six_digit_seg[34:28];
		4'd5:o_seg=i_six_digit_seg[41:35];
	endcase
end

endmodule

// ---------------------------------------------------
// HMS counter (Hour, Minute, Second each counter)
// ---------------------------------------------------
module	hms_cnt(
		o_hms_cnt,
		o_max_hit,
		i_max_cnt,
		clk,
		rst_n);

output	[5:0]	o_hms_cnt	;
output		o_max_hit	;

input	[5:0]	i_max_cnt	;
input		clk		;
input		rst_n		;

reg	[5:0]	o_hms_cnt	;
reg		o_max_hit	;

always @(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		o_hms_cnt <= 6'd0;
		o_max_hit <= 1'b0;
	end else begin
		if(o_hms_cnt >= i_max_cnt) begin
			o_hms_cnt <= 6'd0;
			o_max_hit <= 1'b1;
		end else begin
			o_hms_cnt <= o_hms_cnt + 1'b1;
			o_max_hit <= 1'b0;
		end
	end
end

endmodule

// ---------------------------------------------------
// HMS down counter (Hour, Minute, Second each counter)
// ---------------------------------------------------
module hms_cnt_down ( o_hms_cnt, o_min_hit, i_min_cnt, i_timer_en, clk, rst_n );

output	[5:0]	o_hms_cnt	;	// 0 ~ 59
output		o_min_hit	;	// carry
input	[5:0]	i_min_cnt	;	// 0(m,s,h)
input		i_timer_en	;
input		clk		;
input		rst_n		;

reg	[5:0]	o_hms_cnt	;
reg		o_min_hit	;

always @(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		o_hms_cnt <= 6'd0;
		o_min_hit <= 1'b0;
	end else begin
		case(i_timer_en)
		1'b1 : begin
			if (o_hms_cnt <= i_min_cnt) begin // 0(m,s,h)
				o_hms_cnt <= 6'd59;
				o_min_hit <= 1'b1;
			end else begin // 0~59
				o_hms_cnt <= o_hms_cnt - 1'b1;
				o_min_hit <= 1'b0;
			end
		end
		1'b0 : begin
			if (o_hms_cnt >= 6'd59) begin // 59(m,s) or 23(h)
				o_hms_cnt <= 6'd0;
				o_min_hit <= 1'b1;
			end else begin // 0~59
				o_hms_cnt <= o_hms_cnt + 1'b1;
				o_min_hit <= 1'b0;
			end
		end
		endcase
		
	end
end
endmodule

// ------------------------------------------------
// Hour, Minute, Second total counter
// ------------------------------------------------
module	hourminsec(
		o_sec,
		o_min,
		o_hour,
		o_max_hit_sec,
		o_max_hit_min,
		o_max_hit_hour,
		o_alarm,
		o_timer,
		o_timer_end,
		i_position,
		i_mode,
		i_sec_clk,
		i_min_clk,
		i_hour_clk,
		i_alarm_en,
		i_alarm_sec_clk,
		i_alarm_min_clk,
		i_alarm_hour_clk,
		i_timer_en,
		i_timer_sec_clk,
		i_timer_min_clk,
		i_timer_hour_clk,
		clk,
		rst_n);

parameter	MODE_CLOCK = 2'b00	;
parameter	MODE_SETUP = 2'b01	;
parameter	MODE_ALARM = 2'b10	;
parameter	MODE_TIMER = 2'b11	;
parameter	POS_SEC	   = 2'b00	;
parameter	POS_MIN	   = 2'b01	;
parameter	POS_HOUR   = 2'b10	;	

output		o_sec		;
output		o_min		;
output		o_hour		;
output		o_max_hit_sec	;
output		o_max_hit_min	;
output		o_max_hit_hour	;
output		o_alarm		;
output		o_timer		;
output		o_timer_end	;

input		i_sec_clk	;
input		i_min_clk	;
input		i_hour_clk	;
input		i_alarm_sec_clk	;
input		i_alarm_min_clk	;
input		i_alarm_hour_clk;
input		i_timer_sec_clk	;
input		i_timer_min_clk	;
input		i_timer_hour_clk;
input		i_alarm_en	;
input		i_timer_en	;
input	[1:0]	i_mode		;
input	[1:0]	i_position	;

input		clk		;
input		rst_n		;

//MODE_CLOCK

wire	[5:0]	sec		;
wire		max_hit_sec	;
hms_cnt		u0_hms_cnt(
		.o_hms_cnt	( sec		),
		.o_max_hit	( max_hit_sec	),
		.i_max_cnt	( 6'd59		),
		.clk		( i_sec_clk	),
		.rst_n		( rst_n		));

wire	[5:0]	min		;
wire		max_hit_min	;
hms_cnt		u1_hms_cnt(
		.o_hms_cnt	( min		),
		.o_max_hit	( max_hit_min	),
		.i_max_cnt	( 6'd59		),
		.clk		( i_min_clk	),
		.rst_n		( rst_n		));

wire	[5:0]	hour		;
wire		max_hit_hour	;
hms_cnt		u2_hms_cnt(
		.o_hms_cnt	( hour		),
		.o_max_hit	( max_hit_hour	),
		.i_max_cnt	( 6'd24		),
		.clk		( i_hour_clk	),
		.rst_n		( rst_n		));

//MODE ALARM

wire 	[5:0]	alarm_sec	;
hms_cnt		u_hms_cnt_alarm_sec(
		.o_hms_cnt	( alarm_sec		),
		.o_max_hit	( 			),
		.i_max_cnt	( 6'd59			),
		.clk		( i_alarm_sec_clk	),
		.rst_n		( rst_n			));

wire	[5:0]	alarm_min	;
hms_cnt		u1_hms_cnt_alarm_min(
		.o_hms_cnt	( alarm_min		),
		.o_max_hit	( 			),
		.i_max_cnt	( 6'd59			),
		.clk		( i_alarm_min_clk	),
		.rst_n		( rst_n			));

wire	[5:0]	alarm_hour	;
hms_cnt		u2_hms_cnt_alarm_hour(
		.o_hms_cnt	( alarm_hour		),
		.o_max_hit	( 			),
		.i_max_cnt	( 6'd24			),
		.clk		( i_alarm_hour_clk	),
		.rst_n		( rst_n			));
//MODE TIMER

wire 	[5:0]	timer_sec	;
wire		timer_max_hit_sec	;
hms_cnt_down	u_hms_cnt_timer_sec(
		.o_hms_cnt	( timer_sec		),
		.o_min_hit	( timer_max_hit_sec	),
		.i_min_cnt	( 6'd0			),
		.i_timer_en	( i_timer_en		),
		.clk		( i_timer_sec_clk	),
		.rst_n		( rst_n			));

wire	[5:0]	timer_min	;
wire		timer_max_hit_min	;
hms_cnt_down	u1_hms_cnt_timer_min(
		.o_hms_cnt	( timer_min		),
		.o_min_hit	( timer_max_hit_min	),
		.i_min_cnt	( 6'd0			),
		.i_timer_en	( i_timer_en		),
		.clk		( i_timer_min_clk	),
		.rst_n		( rst_n			));

wire	[5:0]	timer_hour	;
hms_cnt_down	u2_hms_cnt_timer_hour(
		.o_hms_cnt	( timer_hour		),
		.o_min_hit	( 			),
		.i_min_cnt	( 6'd0			),
		.i_timer_en	( i_timer_en		),
		.clk		( i_timer_hour_clk	),
		.rst_n		( rst_n			));

//MUX
reg	[5:0]	o_sec	;
reg	[5:0]	o_min	;
reg	[5:0]	o_hour	;
reg		o_max_hit_sec	;
reg		o_max_hit_min	;
reg		o_max_hit_hour	;

always @(*)begin
	case(i_mode)
		MODE_CLOCK:	begin
			o_sec = sec;
			o_min = min;
			o_hour = hour;
			o_max_hit_sec = max_hit_sec;
			o_max_hit_min = max_hit_min;
		end
		MODE_SETUP: 	begin
			o_sec = sec;
			o_min = min;
			o_hour = hour;
		end
		MODE_ALARM: 	begin
			o_sec = alarm_sec;
			o_min = alarm_min;
			o_hour = alarm_hour;
		end
		MODE_TIMER: begin
			o_sec = timer_sec;
			o_min = timer_min;
			o_hour = timer_hour;
			o_max_hit_sec = timer_max_hit_sec;
			o_max_hit_min = timer_max_hit_min;
		end
		endcase
	end

//Alarm
wire		clk_1hz		;
nco		u1_nco(	
		.clk_gen	( clk_1hz	),
		.num		( 32'd50000000	),
		.clk		( clk		),	
		.rst_n		( rst_n		));

//reg	[3:0]	alarm_cnt	;
/*always @ (posedge clk_1hz or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		alarm_cnt = 0;
	end else begin
		if (o_alarm == 1'b1) begin
			alarm_cnt = alarm_cnt + 1;
		end else begin
			alarm_cnt = 0;
		end
	end
end*/

reg		o_alarm	;
always @ (posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		o_alarm <= 1'b0;
	end else begin
		if((sec == alarm_sec) && (min == alarm_min) && (hour == alarm_hour)) begin
			o_alarm <= 1'b1 & i_alarm_en;
		end else begin
			o_alarm <= o_alarm & i_alarm_en;	
		end
	end
end

// TIMER
reg	o_timer	;
reg	o_timer_end	;
always	@(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		o_timer <= 1'b0;
		o_timer_end <= 1'b1;
	end else begin
		if ((timer_sec == 1'b0) && (timer_min == 1'b0) && (timer_hour == 1'b0)) begin
			o_timer <= 1'b1 & i_timer_en; // buzz
			o_timer_end <= 1'b0;
		end else begin
			o_timer <= o_timer & i_timer_en; // buzz
			o_timer_end <= 1'b1;
		end
	end
end

endmodule

// ---------------------------------------------------
// Controller for clk & mode/position
// ---------------------------------------------------
module	controller(
		o_mode,
		o_position,
		o_sec_clk,
		o_min_clk,
		o_hour_clk,
		o_alarm_en,
		o_alarm_sec_clk,
		o_alarm_min_clk,
		o_alarm_hour_clk,
		o_timer_en,
		o_timer_sec_clk,
		o_timer_min_clk,
		o_timer_hour_clk,
		o_dp,
		i_max_hit_sec,
		i_max_hit_min,
		i_max_hit_hour,
		i_timer_end,
		i_sw0,
		i_sw1,
		i_sw2,
		i_sw3,
		i_sw4,
		rxb,
		clk,
		rst_n);

output	[1:0]	o_mode		;
output	[1:0]	o_position	;
output		o_sec_clk	;
output		o_min_clk	;
output		o_hour_clk	;
output		o_alarm_sec_clk	;
output		o_alarm_min_clk	;
output		o_alarm_hour_clk;
output		o_alarm_en	;
output		o_timer_sec_clk	;
output		o_timer_min_clk	;
output		o_timer_hour_clk;
output		o_timer_en	;
output	[5:0]	o_dp		;

input		i_max_hit_sec	;
input		i_max_hit_min	;
input		i_max_hit_hour	;
input		i_timer_end	;

input		i_sw0		;
input		i_sw1		;
input		i_sw2		;
input		i_sw3		;
input		i_sw4		;

input	[31:0]	rxb		;
input		clk		;
input		rst_n		;

parameter	MODE_CLOCK = 2'b00	;
parameter	MODE_SETUP = 2'b01	;
parameter	MODE_ALARM = 2'b10	;
parameter	MODE_TIMER = 2'b11	;
parameter	POS_SEC	   = 2'b00	;
parameter	POS_MIN	   = 2'b01	;
parameter	POS_HOUR   = 2'b10	;

wire		clk_slow		;

nco		u_nco_db(	
		.clk_gen	( clk_slow	),
		.num		( 32'd500000	),
		.clk		( clk		),
		.rst_n		( rst_n		));

wire		o_sw0			;
wire		o_sw1			;
wire		o_sw2			;
wire		o_sw3			;
wire		o_sw4			;

debounce	u_debounce0(
		.o_sw	( o_sw0		),
		.i_sw	( i_sw0		),
		.clk	( clk_slow	));

debounce	u_debounce1(
		.o_sw	( o_sw1		),
		.i_sw	( i_sw1		),
		.clk	( clk_slow	));
					
debounce	u_debounce2(
		.o_sw	( o_sw2		),
		.i_sw	( i_sw2		),
		.clk	( clk_slow	));

debounce	u_debounce3(
		.o_sw	( o_sw3		),
		.i_sw	( i_sw3		),
		.clk	( clk_slow	));

debounce	u_debounce4(
		.o_sw	( o_sw4		),
		.i_sw	( i_sw4		),
		.clk	( clk_slow	));

//---------------------------
//	remote control
//---------------------------

parameter SIGNAL0 = 32'hFD708F;
parameter SIGNAL1 = 32'hFD08F7;
parameter SIGNAL2 = 32'hFD8877;
parameter SIGNAL3 = 32'hFD48B7;
parameter SIGNAL4 = 32'hFD28D7;

//0	(0xFD708F)
//1	(0XFD08F7)
//2	(0xFD8877)
//3	(0xFD48B7)

reg	i_bt0		;
reg	i_bt1		;
reg	i_bt2		;
reg	i_bt3		;
reg	i_bt4		;

always @(*) begin
	if(rst_n == 0) begin
		i_bt0 = 1'b1;
		i_bt1 = 1'b1;
		i_bt2 = 1'b1;
		i_bt3 = 1'b1;
		i_bt4 = 1'b1;
	end else begin
	case(rxb) 
		SIGNAL0 : begin
		i_bt0 = 1'b0;
		i_bt1 = 1'b1;
		i_bt2 = 1'b1;
		i_bt3 = 1'b1;
		i_bt4 = 1'b1;
		end
		SIGNAL1 : begin
		i_bt0 = 1'b1;
		i_bt1 = 1'b0;
		i_bt2 = 1'b1;
		i_bt3 = 1'b1;
		i_bt4 = 1'b1;
		end
		SIGNAL2 : begin
		i_bt0 = 1'b1;
		i_bt1 = 1'b1;
		i_bt2 = 1'b0;
		i_bt3 = 1'b1;
		i_bt4 = 1'b1;
		end
		SIGNAL3 : begin
		i_bt0 = 1'b1;
		i_bt1 = 1'b1;
		i_bt2 = 1'b1;
		i_bt3 = 1'b0;
		i_bt4 = 1'b1;
		end
		SIGNAL4 : begin
		i_bt0 = 1'b1;
		i_bt1 = 1'b1;
		i_bt2 = 1'b1;
		i_bt3 = 1'b1;
		i_bt4 = 1'b0;
		end
		default : begin
		i_bt0 = 1'b1;
		i_bt1 = 1'b1;
		i_bt2 = 1'b1;
		i_bt3 = 1'b1;
		i_bt4 = 1'b1;
		end

	endcase
	end
end

wire		sw0			;
wire		sw1			;
wire		sw2			;
wire		sw3			;
wire		sw4			;

assign		sw0 = o_sw0 & i_bt0	;
assign		sw1 = o_sw1 & i_bt1	;
assign		sw2 = o_sw2 & i_bt2	;
assign		sw3 = o_sw3 & i_bt3	;
assign		sw4 = o_sw4 & i_bt4	;

reg	[1:0]	o_mode		;
always @(posedge sw0 or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		o_mode <= MODE_CLOCK;
	end else begin
		if(o_mode >= MODE_TIMER) begin
			o_mode <= MODE_CLOCK;
		end else begin
			o_mode <= o_mode + 1'b1;
		end
	end
end
  

reg	[1:0]	o_position	;
always @(posedge sw1 or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		o_position <= POS_SEC;
	end else begin
		if(o_position >= POS_HOUR) begin
			o_position <= POS_SEC;
		end else begin
			o_position <= o_position + 1'b1;
		end
	end
end

reg		o_alarm_en	;
always @(posedge sw3 or negedge rst_n) begin
	if(rst_n == 1'b0) begin
		o_alarm_en <= 1'b0;
	end else begin
		o_alarm_en <= o_alarm_en + 1'b1;
	end
end

reg		o_timer_en	;
always	@(posedge sw4 or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		o_timer_en <= 1'b0;
	end else begin
		o_timer_en <= o_timer_en + 1'b1;
	end
end

// mode dp
reg   [5:0]   o_dp      ;
always @(*) begin
   if(o_alarm_en == 1'b0) begin
      case(o_mode)
      MODE_CLOCK : o_dp = 6'b000001;
      MODE_SETUP : o_dp = 6'b000010;
      MODE_ALARM : o_dp = 6'b000100;
      MODE_TIMER : o_dp = 6'b001000;
      endcase
    end else begin            //when alarm_en is on, display dot
      case(o_mode)
      MODE_CLOCK : o_dp = 6'b100001;
      MODE_SETUP : o_dp = 6'b100010;
      MODE_ALARM : o_dp = 6'b100100;
      MODE_TIMER : o_dp = 6'b101000;
      endcase
   end
end   

wire		clk_1hz		;

nco		u_nco(	
		.clk_gen	( clk_1hz	),
		.num		( 32'd50000000	),
		.clk		( clk		),
		.rst_n		( rst_n		));

reg		o_sec_clk	;
reg		o_min_clk	;
reg		o_hour_clk	;
reg		o_alarm_sec_clk	;
reg		o_alarm_min_clk	;
reg		o_alarm_hour_clk;
reg		o_timer_sec_clk	;
reg		o_timer_min_clk	;
reg		o_timer_hour_clk;

always @(*) begin
	case(o_mode)
		MODE_CLOCK : begin
			o_sec_clk = clk_1hz;
			o_min_clk = i_max_hit_sec;
			o_hour_clk = i_max_hit_min;
			o_alarm_sec_clk = 1'b0;
			o_alarm_min_clk = 1'b0;
			o_alarm_hour_clk = 1'b0;
			if (i_timer_end == 1'b1 && sw4 == 1'b1) begin // timer running
				o_timer_sec_clk = clk_1hz;
				o_timer_min_clk = i_max_hit_sec;
				o_timer_hour_clk = i_max_hit_min;
			end else begin // sw4 on and timer running
				o_timer_sec_clk = 1'b0;
				o_timer_min_clk = 1'b0;
				o_timer_hour_clk = 1'b0;
			end
		end
		MODE_SETUP : begin
			case(o_position)
			POS_SEC : begin
				o_sec_clk = ~sw2;
				o_min_clk = 1'b0;
				o_hour_clk = 1'b0;
				o_alarm_sec_clk = 1'b0;
				o_alarm_min_clk = 1'b0;
				o_alarm_hour_clk = 1'b0;
				if (i_timer_end == 1'b1 && sw4 == 1'b1) begin // timer running
					o_timer_sec_clk = clk_1hz;
					o_timer_min_clk = i_max_hit_sec;
				o_timer_hour_clk = i_max_hit_min;
				end else begin // sw4 on and timer running
					o_timer_sec_clk = 1'b0;
					o_timer_min_clk = 1'b0;
					o_timer_hour_clk = 1'b0;
				end
			end
			POS_MIN : begin
				o_sec_clk = 1'b0;
				o_min_clk = ~sw2;
				o_hour_clk = 1'b0;
				o_alarm_sec_clk = 1'b0;
				o_alarm_min_clk = 1'b0;
				o_alarm_hour_clk = 1'b0;
				if (i_timer_end == 1'b1 && sw4 == 1'b1) begin // timer running
					o_timer_sec_clk = clk_1hz;
					o_timer_min_clk = i_max_hit_sec;
				o_timer_hour_clk = i_max_hit_min;
				end else begin // sw4 on and timer running
					o_timer_sec_clk = 1'b0;
					o_timer_min_clk = 1'b0;
					o_timer_hour_clk = 1'b0;
				end
			end
			POS_HOUR : begin
				o_sec_clk = 1'b0;
				o_min_clk = 1'b0;
				o_hour_clk = ~sw2;
				o_alarm_sec_clk = 1'b0;
				o_alarm_min_clk = 1'b0;
				o_alarm_hour_clk = 1'b0;
				if (i_timer_end == 1'b1 && sw4 == 1'b1) begin // timer running
					o_timer_sec_clk = clk_1hz;
					o_timer_min_clk = i_max_hit_sec;
				o_timer_hour_clk = i_max_hit_min;
				end else begin // sw4 on and timer running
					o_timer_sec_clk = 1'b0;
					o_timer_min_clk = 1'b0;
					o_timer_hour_clk = 1'b0;
				end
			end
			endcase
		end
		MODE_ALARM : begin
			case(o_position)
			POS_SEC : begin
				o_sec_clk = clk_1hz;
				o_min_clk = i_max_hit_sec;
				o_hour_clk = i_max_hit_min;
				o_alarm_sec_clk = ~sw2;
				o_alarm_min_clk = 1'b0;
				o_alarm_hour_clk = 1'b0;
				if (i_timer_end == 1'b1 && sw4 == 1'b1) begin // timer running
					o_timer_sec_clk = clk_1hz;
					o_timer_min_clk = i_max_hit_sec;
				o_timer_hour_clk = i_max_hit_min;
				end else begin // sw4 on and timer running
					o_timer_sec_clk = 1'b0;
					o_timer_min_clk = 1'b0;
					o_timer_hour_clk = 1'b0;
				end
			end
			POS_MIN : begin
				o_sec_clk = clk_1hz;
				o_min_clk = i_max_hit_sec;
				o_hour_clk = i_max_hit_min;
				o_alarm_sec_clk = 1'b0;
				o_alarm_min_clk = ~sw2;
				o_alarm_hour_clk = 1'b0;
				if (i_timer_end == 1'b1 && sw4 == 1'b1) begin // timer running
					o_timer_sec_clk = clk_1hz;
					o_timer_min_clk = i_max_hit_sec;
				o_timer_hour_clk = i_max_hit_min;
				end else begin // sw4 on and timer running
					o_timer_sec_clk = 1'b0;
					o_timer_min_clk = 1'b0;
					o_timer_hour_clk = 1'b0;
				end
			end
			POS_HOUR : begin
				o_sec_clk = clk_1hz;
				o_min_clk = i_max_hit_sec;
				o_hour_clk = i_max_hit_min;
				o_alarm_sec_clk = 1'b0;
				o_alarm_min_clk = 1'b0;
				o_alarm_hour_clk = ~sw2;
				if (i_timer_end == 1'b1 && sw4 == 1'b1) begin // timer running
					o_timer_sec_clk = clk_1hz;
					o_timer_min_clk = i_max_hit_sec;
				o_timer_hour_clk = i_max_hit_min;
				end else begin // sw4 on and timer running
					o_timer_sec_clk = 1'b0;
					o_timer_min_clk = 1'b0;
					o_timer_hour_clk = 1'b0;
				end
			end
			endcase
		end
		MODE_TIMER : begin // TIMER mode
			case(o_position) // sw4 off(on_timer_en == 1'b1) >> SETUP MODE clk, sw4 on(on_timer_en == 1'b0) >> CLOCK MODE clk
			POS_SEC : begin 
				o_sec_clk = clk_1hz;
				o_min_clk = i_max_hit_sec;
				o_hour_clk = i_max_hit_min;
				o_alarm_sec_clk = 1'b0;
				o_alarm_min_clk = 1'b0;
				o_alarm_hour_clk = 1'b0;
				if (o_timer_en == 1'b0 || i_timer_end == 1'b0) begin // sw4 off or timer end
					o_timer_sec_clk = ~sw2;
					o_timer_min_clk = 1'b0;
					o_timer_hour_clk = 1'b0;
				end else begin // sw4 on and timer running
					o_timer_sec_clk = clk_1hz;
					o_timer_min_clk = i_max_hit_sec;
					o_timer_hour_clk = i_max_hit_min;
				end
			end
			POS_MIN : begin
				o_sec_clk = clk_1hz;
				o_min_clk = i_max_hit_sec;
				o_hour_clk = i_max_hit_min;
				o_alarm_sec_clk = 1'b0;
				o_alarm_min_clk = 1'b0;
				o_alarm_hour_clk = 1'b0;
				if (o_timer_en == 1'b0 || i_timer_end == 1'b0) begin // sw4 off or timer end
					o_timer_sec_clk = 1'b0;
					o_timer_min_clk = ~sw2;
					o_timer_hour_clk = 1'b0;
				end else begin // sw4 on and timer running
					o_timer_sec_clk = clk_1hz;
					o_timer_min_clk = i_max_hit_sec;
					o_timer_hour_clk = i_max_hit_min;
				end
			end
			POS_HOUR : begin
				o_sec_clk = clk_1hz;
				o_min_clk = i_max_hit_sec;
				o_hour_clk = i_max_hit_min;
				o_alarm_sec_clk = 1'b0;
				o_alarm_min_clk = 1'b0;
				o_alarm_hour_clk = 1'b0;
				if (o_timer_en == 1'b0 || i_timer_end == 1'b0) begin // sw4 off or timer end
					o_timer_sec_clk = 1'b0;
					o_timer_min_clk = 1'b0;
					o_timer_hour_clk = ~sw2;
				end else begin // sw4 on and timer running
					o_timer_sec_clk = clk_1hz;
					o_timer_min_clk = i_max_hit_sec;
					o_timer_hour_clk = i_max_hit_min;
				end
			end
			endcase
		end
	endcase
end

endmodule


// ---------------------------------------------------
// Top module 
// ---------------------------------------------------
module	top_hms_clock(
		o_seg_enb,
		o_seg_dp,
		o_seg,
		o_alarm,
		o_timer,
		i_sw0,
		i_sw1,
		i_sw2,
		i_sw3,
		i_sw4,
		i_ir_rxb,
		clk,
		rst_n);

output	[5:0]	o_seg_enb	;
output		o_seg_dp	;
output	[6:0]	o_seg		;
output		o_alarm		;
output		o_timer		;

input		i_sw0		;
input		i_sw1		;
input		i_sw2		;
input		i_sw3		;
input		i_sw4		;
input		i_ir_rxb	;
input		clk		;
input		rst_n		;

wire	[1:0]	mode		;
wire	[1:0]	position	;
wire		sec_clk		;
wire		min_clk		;
wire		hour_clk	;
wire		sec_clk_alarm	;
wire		min_clk_alarm	;
wire		hour_clk_alarm 	;
wire		sec_clk_timer	;
wire		min_clk_timer	;
wire		hour_clk_timer 	;
wire		max_hit_sec	;
wire		max_hit_min	;
wire		max_hit_hour	;
wire		alarm_en	;
wire		alarm		;
wire		timer_en	;
wire		timer		;
wire		timer_end	;
wire	[5:0]	dp		;

wire	[31:0]	signal		;

ir_rx		u_ir_rx(
		.o_data		( signal	),
		.i_ir_rxb	( i_ir_rxb	),
		.clk		( clk		),
		.rst_n		( rst_n		));

controller	u_ctrl(
		.o_mode			( mode		),
		.o_position		( position	),
		.o_sec_clk		( sec_clk	),
		.o_min_clk		( min_clk	),
		.o_hour_clk		( hour_clk	),
		.o_alarm_en		( alarm_en	),
		.o_alarm_sec_clk	( sec_clk_alarm	), 
		.o_alarm_min_clk	( min_clk_alarm	),
		.o_alarm_hour_clk	( hour_clk_alarm),
		.o_timer_en		( timer_en	),
		.o_timer_sec_clk	( sec_clk_timer	), 
		.o_timer_min_clk	( min_clk_timer	),
		.o_timer_hour_clk	( hour_clk_timer),
		.o_dp			( dp		), 
		.i_max_hit_sec		( max_hit_sec	),
		.i_max_hit_min		( max_hit_min	),
		.i_max_hit_hour		( max_hit_hour	),
		.i_timer_end		( timer_end	),
		.i_sw0			( i_sw0		),
		.i_sw1			( i_sw1		),
		.i_sw2			( i_sw2		),
		.i_sw3			( i_sw3		),
		.i_sw4			( i_sw4		),
		.rxb			( signal	),
		.clk			( clk		),
		.rst_n			( rst_n		));

wire	[5:0]	sec		;
wire 	[5:0]	min		;
wire	[5:0]	hour		;

hourminsec	u_hms(
		.o_sec			( sec		),
		.o_min			( min		),
		.o_hour			( hour		),
		.o_max_hit_sec		( max_hit_sec	),
		.o_max_hit_min		( max_hit_min	),
		.o_max_hit_hour		( max_hit_hour	),
		.o_alarm		( alarm		),
		.o_timer		( timer		),
		.o_timer_end		( timer_end	),
		.i_position		( position	),
		.i_sec_clk		( sec_clk	),
		.i_min_clk		( min_clk	),
		.i_hour_clk		( hour_clk	),
		.i_mode			( mode		),
		.i_alarm_en		( alarm_en	),
		.i_alarm_sec_clk	( sec_clk_alarm	),
		.i_alarm_min_clk	( min_clk_alarm	),
		.i_alarm_hour_clk	( hour_clk_alarm),
		.i_timer_en		( timer_en	),
		.i_timer_sec_clk	( sec_clk_timer	),
		.i_timer_min_clk	( min_clk_timer	),
		.i_timer_hour_clk	( hour_clk_timer),
		.clk			( clk		),
		.rst_n			( rst_n		));
		
buzz		u_buzz0 ( .o_buzz ( o_alarm ), .i_buzz_en ( alarm|timer ), .clk ( clk ), .rst_n ( rst_n ) );

wire	[3:0]	sec_l		;
wire	[3:0]	sec_r		;

double_fig_sep		u0_dfs(	
			.o_left		( sec_l		),
			.o_right	( sec_r		),
			.i_double_fig	( sec		));

wire	[3:0]	min_l		;
wire	[3:0]	min_r		;

double_fig_sep		u1_dfs(	
			.o_left		( min_l		),
			.o_right	( min_r		),
			.i_double_fig	( min		));

wire	[3:0]	hour_l		;
wire	[3:0]	hour_r		;

double_fig_sep		u2_dfs(	
			.o_left		( hour_l	),
			.o_right	( hour_r	),
			.i_double_fig	( hour		));

wire	[6:0]	sec_l_seg	;
wire	[6:0]	sec_r_seg	;

fnd_dec		u0_fnd_dec(
		.o_seg		( sec_l_seg	),
		.i_num		( sec_l		));

fnd_dec		u1_fnd_dec(
		.o_seg		( sec_r_seg	),
		.i_num		( sec_r		));

wire	[6:0]	min_l_seg	;
wire	[6:0]	min_r_seg	;

fnd_dec		u2_fnd_dec(
		.o_seg		( min_l_seg	),
		.i_num		( min_l		));

fnd_dec		u3_fnd_dec(
		.o_seg		( min_r_seg	),
		.i_num		( min_r		));

wire	[6:0]	hour_l_seg	;
wire	[6:0]	hour_r_seg	;

fnd_dec		u4_fnd_dec(
		.o_seg		( hour_l_seg	),
		.i_num		( hour_l	));

fnd_dec		u5_fnd_dec(
		.o_seg		( hour_r_seg	),
		.i_num		( hour_r	));

wire	[41:0]	six_digit_seg	;
assign		six_digit_seg = { hour_l_seg, hour_r_seg, min_l_seg, min_r_seg, sec_l_seg, sec_r_seg };

led_disp	u_led_disp(	
		.o_seg			( o_seg		),
		.o_seg_dp		( o_seg_dp	),
		.o_seg_enb		( o_seg_enb	),
		.i_six_digit_seg	( six_digit_seg	),
		.i_six_dp		( dp		),	
		.i_position		( position	),
		.i_mode			( mode		),
		.i_timer_en		( timer_en	),
		.clk			( clk		),
		.rst_n			( rst_n		));

endmodule

// ---------------------------------------------------
// buzz
// ---------------------------------------------------
module	debounce(
		o_sw,
		i_sw,
		clk);

output		o_sw		;

input		i_sw		;
input		clk		;

reg		dly1_sw		;

always @(posedge clk) begin
	dly1_sw <= i_sw;
end

reg		dly2_sw		;

always @(posedge clk) begin
	dly2_sw <= dly1_sw	;
end

assign	o_sw = dly1_sw | ~dly2_sw;

endmodule
