//@version=3
strategy("Tick Test FX", overlay=true, default_qty_type=strategy.percent_of_equity, default_qty_value=100)

// Inputs
st_yr_inp = input(defval=2019, title='Backtest Start Year', type=integer)
st_mn_inp = input(defval=10, title='Backtest Start Month', type=integer)
st_dy_inp = input(defval=02, title='Backtest Start Day', type=integer)
en_yr_inp = input(defval=2020, title='Backtest End Year', type=integer)
en_mn_inp = input(defval=10, title='Backtest End Month', type=integer)
en_dy_inp = input(defval=03, title='Backtest End Day', type=integer)
loss_ticks = input(defval=20, title='Stop Loss in Ticks', type=integer)
profit_ticks = input(defval=40, title='Profit in Ticks', type=integer)

// Timestamp
start = timestamp(st_yr_inp, st_mn_inp, st_dy_inp,00,00)
end = timestamp(en_yr_inp, en_mn_inp, en_dy_inp,00,00)
can_trade = time >= start and time <= end

ma = sma(close, 100)

if (can_trade and crossover(close, ma))
    strategy.entry("long", strategy.long)
    strategy.exit("SL/TP","long", loss=loss_ticks, profit=profit_ticks)

plot(ma, linewidth=2)