//@version=3
strategy("HLHB Trend-Following System", shorttitle="HLHB TFS", overlay=true,
  default_qty_type=strategy.percent_of_equity, default_qty_value=100)

// -----------------------------------------------------------------------------
// STRATEGY REQUIREMENTS
// -----------------------------------------------------------------------------
//
// Setup
// -----
//  - EUR/USD 1-hour chart
//  - GBP/USD 1-hour chart
//  - 5 EMA: blue line
//  - 10 EMA: red line
//  - RSI (10) applied to the median price (HL/2)
//  - ADX (14)
//
// Entry
// -----
//  - BUY when the 5 EMA crosses above the 10 EMA from underneath and the RSI
//    crosses above the 50.0 mark from the bottom.
//  - SELL when the 5 EMA crosses below the 10 EMA from the top and the RSI
//    crosses below the 50.0 mark from the top.
//  - Make sure that the RSI did cross 50.0 from the top or bottom and not just
//    ranging tightly around the level.
//  - ADX > 25 for Buy and Sells
//
// Exit
// ----
//  - Use a 50-pip trailing stop and a 200-pip profit target. This increases the
//    chances of the system riding longer trends.
//  - Close the trade when a new signal materializes.
//  - Close all trades by the end of the week.
//
// -----------------------------------------------------------------------------

// Variabili della strategia
// -------------------
ema_fast_len = input(5, title='Fast EMA Length')
ema_slow_len = input(10 , title='Slow EMA Length')
rsi_len = input(10, title='Slow EMA Length')
session_end_hour = input(16, minval=0, maxval=23, title='Weekly Session End (Hour)')
session_end_minute = input(0, minval=0, maxval=59, title='Weekly Session End (Minute)')
profit_target = input(400, title='Profit Target (Pips/Points)')
trailing_stop_dist = input(150, title='Trailing Stop Distance (Pips/Points)')
adx_filt = input(true, title='User ADX Filter')
adx_min = input(25, minval=0, title='Minimum ADX Level')
adx_len = input(14, title="ADX Smoothing")
di_len = input(14, title="DI Length")

// Indicatori
ema_fast = ema(close, ema_fast_len)
ema_slow = ema(close, ema_slow_len)
rsi_ind = rsi(close, rsi_len)

// ADX
adx_dirmov(len) =>
	up = change(high)
	down = -change(low)
	plusDM = na(up) ? na : (up > down and up > 0 ? up : 0)
    minusDM = na(down) ? na : (down > up and down > 0 ? down : 0)
	truerange = rma(tr, len)
	plus = fixnan(100 * rma(plusDM, len) / truerange)
	minus = fixnan(100 * rma(minusDM, len) / truerange)
	[plus, minus]

adx_adx(dilen, adxlen) =>
	[plus, minus] = adx_dirmov(dilen)
	sum = plus + minus
	adx = 100 * rma(abs(plus - minus) / (sum == 0 ? 1 : sum), adxlen)
	[adx, plus, minus]

[adx_sig, adx_plus, adx_minus] = adx_adx(di_len, adx_len)


// Logica della strategia
ema_long_cross = crossover(ema_fast, ema_slow)
ema_short_cross = crossunder(ema_fast, ema_slow)
rsi_long_cross = crossover(rsi_ind, 50)
rsi_short_cross = crossunder(rsi_ind, 50)
adx_check = adx_filt ? adx_sig >= adx_min : true

longCondition = ema_long_cross and rsi_long_cross and adx_check
if (longCondition)
    strategy.entry("Long", strategy.long)

shortCondition = ema_short_cross and rsi_short_cross and adx_check
if (shortCondition)
    strategy.entry("Short", strategy.short)

strategy.exit("SL/TP", "Long", profit=profit_target,  loss=trailing_stop_dist, trail_points=trailing_stop_dist)
strategy.exit("SL/TP", "Short", profit=profit_target, loss=trailing_stop_dist, trail_points=trailing_stop_dist)

// Friday = 6
// se manchiamo l'orario di chiusura per qualsiasi motivo, allora chiudiamo immediatamente
// altrimenti se siamo nell'orario di chiusura allora verifichiamo se siamo nel minuto di chiusura
close_time = dayofweek == 6 ?
  hour[0] > session_end_hour ? true :
  hour[0] == session_end_hour ?
      minute[0] >= session_end_minute :
  false : false

strategy.close_all(when=close_time)

// Grafico
plot(ema_fast, color=blue, title="Fast EMA")
plot(ema_slow, color=red, title="Slow EMA")

plotshape(rsi_long_cross, style=shape.triangleup, size=size.tiny, location=location.belowbar, color=green, title='RSI Long Cross Marker')
plotshape(rsi_short_cross, style=shape.triangledown, size=size.tiny, location=location.abovebar, color=red, title='RSI Short Cross Marker')

// Sfondo Filtro ADX
bgcolor(adx_filt and adx_check ? orange : na, transp=90)