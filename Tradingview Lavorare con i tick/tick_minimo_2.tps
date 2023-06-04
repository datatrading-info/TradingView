//@version=3
 strategy("Tick Test 2", overlay=true)

// Inputs
st_yr_inp = input(defval=2019, title='Backtest Start Year', type=integer)
st_mn_inp = input(defval=10, title='Backtest Start Month', type=integer)
st_dy_inp = input(defval=02, title='Backtest Start Day', type=integer)
en_yr_inp = input(defval=2019, title='Backtest End Year', type=integer)
en_mn_inp = input(defval=10, title='Backtest End Month', type=integer)
en_dy_inp = input(defval=03, title='Backtest End Day', type=integer)
ticks = input(defval=10, title='Stop Loss in Ticks', type=integer)

// Timestamp
start = timestamp(st_yr_inp, st_mn_inp, st_dy_inp,00,00)
end = timestamp(en_yr_inp, en_mn_inp, en_dy_inp,00,00)
can_trade = time >= start and time <= end

if (can_trade)
    strategy.entry("long", strategy.long)
    strategy.exit("Stop Order","long", loss=ticks)