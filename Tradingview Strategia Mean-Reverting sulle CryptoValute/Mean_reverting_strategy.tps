//@version=3
strategy("EMA, SMA Mean Reversion", overlay=true, default_qty_type=strategy.percent_of_equity, default_qty_value=100)

// Input
st_yr_inp = input(defval=2017, title='Backtest Start Year', type=integer)
st_mn_inp = input(defval=01, title='Backtest Start Month', type=integer)
st_dy_inp = input(defval=01, title='Backtest Start Day', type=integer)
en_yr_inp = input(defval=2025, title='Backtest End Year', type=integer)
en_mn_inp = input(defval=01, title='Backtest End Month', type=integer)
en_dy_inp = input(defval=01, title='Backtest End Day', type=integer)
sma_lookback = input(defval=100, title="Lookback Period For SMA")
ema_lookback = input(defval=10, title="Lookback Period For EMA")
long_diff_perc = input(defval=6, title="Percentage Deviation From SMA to go Long") / 100
short_diff_perc = input(defval=20, title="Percentage Deviation From SMA to go Short") / 100
ema_filter_bars = input(defval=4, title="The number of bars the EMA must rise/fall")
lng_allwd = input(defval=true, title="Allow Longs?")
srt_allwd = input(defval=true, title="Allow Shorts?")
use_stop = input(defval=true, title="Use Stoploss?")
stop_perc = input(defval=30, title="Stop Loss Percentage") / 100

// Date
start = timestamp(st_yr_inp, st_mn_inp, st_dy_inp, 00, 00)
end = timestamp(en_yr_inp, en_mn_inp, en_dy_inp, 00, 00)
can_trade = time >= start and time <= end
// Indicators
Setup
sma = sma(close, sma_lookback)
ema = ema(close, ema_lookback)

// Strategia
Calcuations
close_stdev = stdev(close, sma_lookback)
sd1_upper = close + (close_stdev * 1)
sd1_lower = close - (close_stdev * 1)
close_diff = (close - sma) / sma

// Entrate e Uscite
longCondition = close_diff <= -long_diff_perc and rising(ema, ema_filter_bars) and lng_allwd and can_trade
if (longCondition)
    strategy.entry("Long", strategy.long)
    if use_stop
        stop_price = close * (1 - stop_perc)
        strategy.order("Long Stoploss", false, stop=stop_price)

shortCondition = close_diff >= short_diff_perc and falling(ema, ema_filter_bars) and srt_allwd and can_trade
if (shortCondition)
    strategy.entry("Short", strategy.short)
    if use_stop
        stop_price = close * (1 + stop_perc)
        strategy.order("Short Stoploss", true, stop=stop_price)

strategy.close("Long", when=close_diff >= 0)
strategy.cancel("Long Stoploss", when=close_diff >= 0)
strategy.close("Short", when=close_diff <= 0)
strategy.cancel("Short Stoploss", when=close_diff <= 0)

// Grafico
sma_col = sma > sma[1] ? green: red
ema_fill = close_diff <= -long_diff_perc ? lime: close_diff >= short_diff_perc ? maroon: aqua
p_sma = plot(sma, color=sma_col, linewidth=3)
p_ema = plot(ema, color=black, linewidth=2)
p_sd1 = plot(sd1_upper, color=black, linewidth=1, transp=85)
p_sd2 = plot(sd1_lower, color=black, linewidth=1, transp=85)
fill(p_sd1, p_sd2, title='STDEV Fill', color=silver, transp=80)
fill(p_sma, p_ema, title='EMA > Mean Percentage', color=ema_fill, transp=80)