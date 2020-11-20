## P1
#### P1 - 알람용 HMS Counter에서 o_max_hit를 비워둔 이유
<br>

```verilog
// MODE: CLOCK counter
wire	[5:0]	sec		;
wire		max_hit_sec	;
hms_cnt		u0_hms_cnt ( .o_hms_cnt ( sec ), .o_max_hit ( o_max_hit_sec ), .i_max_cnt ( 6'd59 ), .clk ( i_sec_clk ), .rst_n ( rst_n ) ); // sec counter

wire	[5:0]	min		;
wire		max_hit_min	;
hms_cnt		u1_hms_cnt ( .o_hms_cnt ( min ), .o_max_hit ( o_max_hit_min ), .i_max_cnt ( 6'd59 ), .clk ( i_min_clk ), .rst_n ( rst_n ) ); // min counter

// MODE: ALARM counter
wire	[5:0]	alarm_sec	;
hms_cnt		u2_hms_cnt ( .o_hms_cnt ( alarm_sec ), .o_max_hit ( ), .i_max_cnt ( 6'd59 ), .clk ( i_alarm_sec_clk ), .rst_n ( rst_n ) ); // sec counter

wire	[5:0]	alarm_min	;
hms_cnt		u3_hms_cnt ( .o_hms_cnt ( alarm_min ), .o_max_hit ( ), .i_max_cnt ( 6'd59 ), .clk ( i_alarm_min_clk ), .rst_n ( rst_n ) ); // sec counter
```
<br>
hms_cnt는 들어오는 clk에 따라 0부터 i_max_cnt(6'd59)까지 증가하는 모듈이다.<br>
o_max_hit은 i_max_cnt(6'd59)에서 다시 0으로 초기화될 때만 1로 증가하는데
이는 sec의 hms_cnt가 i_max_cnt(6'd59)에서 0으로 감소할 때 min의 hms_cnt의 clk으로 1이 전달된다.<br>
즉, sec의 o_max_hit은 min의 clk이다. 이는 sec이 60이 되면 1 min으로 변하기 때문이다.<br><br>
하지만 alarm은 그럴 필요가 없다. hms cnt에서 들어오는 clk은 사용자가 버튼을 누를 때 생성된다.<br>
시간이 증가하는 것이 목적이 아니라 시간을 설정하는 것이 목적이므로 60초가 1분으로 꼭 증가할 필요가 없다.<br>

## A1
#### A1
<br>

```verilog
// ALARM
wire		clk_1hz	;

nco	u1_nco ( .clk_gen ( clk_1hz ), .num ( 32'd50000000 ), .clk ( clk ), .rst_n ( rst_n ));

reg	[3:0]	alarm_cnt	;

always	@(posedge clk_1hz or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		alarm_cnt = 0;
	end else begin
		if (o_alarm == 1'b1) begin
			alarm_cnt = alarm_cnt + 1;
		end else begin
			alarm_cnt = 0;
		end
	end
end

reg		o_alarm	;

always	@(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		o_alarm <= 1'b0;
	end else begin
		if ((sec == alarm_sec) && (min == alarm_min)) begin
			o_alarm <= 1'b1 & i_alarm_en;
		end else begin
			if (alarm_cnt >= 4'd5) begin
				o_alarm <= 0;
			end
		end
	end
end
```
<br>
o_alarm은 alarm 기능을 ON/OFF하는 값이다. o_alarm이 ON일때 alarm_cnt를 시작하는데 alarm_cnt가 5이상일 때는 o_alarm이 OFF 된다. o_alarm이 OFF되면 alarm_cnt 다시 초기화된다.
